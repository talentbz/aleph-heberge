<?php
class Route
{
    public $param_1;
    public $param_2;
    public $param_3;
    public $param_4;
    public $action;

    public function __construct()
    {
        $this->param_1 = route(0);
        $this->param_2 = route(1);
        $this->param_3 = route(2);
        $this->param_4 = route(4);
    }
}
