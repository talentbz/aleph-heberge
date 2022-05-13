<?php

use Illuminate\Console\Scheduling\Schedule;

class ScheduleRun extends Command
{
    protected $signature = 'schedule:run';
    protected $description = 'Schedule tasks';

    public function handle()
    {
        $this->appInit();
        if ($this->settings['url_rewrite'] == '1') {
            define('BASE_URL', APP_URL . '/');
        } else {
            define('BASE_URL', APP_URL . '/?ng=');
        }

        // initialize container/app
        $container = App::getInstance();
        $container->instance('app', $container);

        // initialize exception handler
        $container->bind(
            \Illuminate\Contracts\Debug\ExceptionHandler::class,
            ExceptionHandler::class
        );

        // initialize event dispatcher
        $container->singleton(
            \Illuminate\Contracts\Events\Dispatcher::class,
            function (\Illuminate\Container\Container $container) {
                return new \Illuminate\Events\Dispatcher($container);
            }
        );

        // initialize file cache for schedule mutex
        $container->instance(
            'config',
            new \Illuminate\Config\Repository(require 'system/env.php')
        );
        $container->instance('files', new Filesystem());
        $container->singleton(
            \Illuminate\Contracts\Cache\Factory::class,
            function (\Illuminate\Container\Container $container) {
                return new \Illuminate\Cache\CacheManager($container);
            }
        );

        // initialize schedule
        $container->singleton(Schedule::class, function (): Schedule {
            return tap(new Schedule('UTC'), function (
                Schedule $schedule
            ): void {
                $schedule->useCache('file'); // cache store name to use for mutex
            });
        });

        // configure schedule with scheduled commands/callbacks like normal
        $schedule = $container->make(Schedule::class);

        $schedule
            ->call(function () {
                $config = [
                    'currency_decimal_digits' =>
                        $this->settings['currency_decimal_digits'],
                ];
                $cron_log = new CronLog();
                $cron_log->date = date('Y-m-d');
                $logs = '';
                $logs .=
                    '================================================== <br>';
                $logs .=
                    date('Y-m-d H:i:s') .
                    ' : Schedule Jobs Started....... <br>';
                Invoice::generateRecurringInvoices($this->settings, $this->_L);
                if (
                    $this->settings_exist_and_true(
                        'task_daily_accounting_snapshot'
                    )
                ) {
                    $accounting_snapshot = Account::createSnapshot(
                        $this->settings,
                        $this->_L
                    );
                    if ($accounting_snapshot) {
                        $logs .= $accounting_snapshot['message'];
                        if (
                            !empty(
                                $this->settings['global_notifications_email']
                            )
                        ) {
                            Email::sendEmail(
                                $this->settings,
                                $this->_L,
                                $this->settings['CompanyName'],
                                $this->settings['global_notifications_email'],
                                'Accounting Snapshot',
                                $accounting_snapshot['message']
                            );
                        }
                    }
                }
                if (
                    $this->settings_exist_and_true(
                        'task_automatic_payment_reminder'
                    )
                ) {
                    Invoice::sendPaymentReminder($this->settings, $this->_L);
                }
                $cron_log->logs = $logs;
                $cron_log->save();
            })
            ->daily();

        //                $schedule
        //                    ->call(function () {
        //                        Logger::write('run success...');
        //                    })
        //                    ->everyMinute();

        // initialize schedule:run command
        $scheduler = new \Illuminate\Console\Scheduling\ScheduleRunCommand();
        $scheduler->setLaravel($container);
        $input = new \Symfony\Component\Console\Input\ArrayInput([]);
        $output = new \Symfony\Component\Console\Output\BufferedOutput();
        $scheduler->setInput($input);
        $scheduler->setOutput(
            new \Illuminate\Console\OutputStyle($input, $output)
        );

        // run command without console application around
        $scheduler->handle(
            $schedule,
            $container->make(\Illuminate\Contracts\Events\Dispatcher::class),
            $container->make(
                \Illuminate\Contracts\Debug\ExceptionHandler::class
            )
        );
        $this->info($output->fetch());
    }

    protected function settings_exist_and_true($key)
    {
        if (isset($this->settings[$key]) && $this->settings[$key]) {
            return true;
        }
        return false;
    }
}
