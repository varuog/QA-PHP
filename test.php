<?php
/*
spl_autoload_register(function($name)
                        {
                            require_once "$name.php";
                        }
                    , true);


session_set_save_handler(new SessionDatabase(DatabaseHandle::getConnection()),true);
session_start();

var_dump($_SESSION);
/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
class test
{
    private $foo;
    
    public function __construct($foo) {
        $this->foo=$foo;
    }
}


?>
