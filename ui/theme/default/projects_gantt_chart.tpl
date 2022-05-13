{extends file="project_base.tpl"}

{block name="head"}
    <link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/frappe-gantt@0.5.0/dist/frappe-gantt.css" />
{/block}

{block name="project_content"}
    <svg id="gantt"></svg>
{/block}

{block name="script"}
{*    <script type="text/javascript" src="{$app_url}ui/lib/gantt/jquery.fn.gantt.min.js"></script>*}
    <script src="https://cdn.jsdelivr.net/combine/npm/snapsvg@0.5.1,npm/frappe-gantt@0.5.0/dist/frappe-gantt.min.js"></script>
    <script>
        $(function () {

            var tasks = [
                {foreach $tasks as $task}
                {
                    id: '{$task->id}',
                    name: '{$task->title}',
                    start: '{$task->started}',
                    end: '{$task->due_date}',

                    {if $task->status === 'In Progress'}
                    progress: 70,
                    {elseif $task->status === 'Not Started'}
                    progress: 0,
                    {elseif $task->status === 'Completed'}
                    progress: 100,
                    {elseif $task->status === 'Waiting on someone else'}
                    progress: 50,
                    {elseif $task->status === 'Deferred'}
                    progress: 40,
                    {else}
                    progress: 50,
                    {/if}
                    // dependencies: 'Task 2, Task 3'
                },
                {/foreach}
            ]
            var gantt = new Gantt("#gantt", tasks);
        });
    </script>
{/block}
