<?php

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
require_once 'models/DependencyObject.php';

/**
 * Description of AbstractController
 * @todo layout basic controller set up
 * @todo Ensure intigrity of controllers- methods are public,final,no args
 * @author Gourav Sarkar
 */
abstract class AbstractController {

    //put your code here
    protected $model;
    protected $view;
    //Boolean flag indicates if controller data is called via ajax request
    protected $isAjax = false;

    public function __construct() {
        $this->view = new Render();

        if (isset($_GET['ajax'])) {
            $this->isAjax = (bool) $_GET['ajax'];
        }
        
        
        //Common template for all module
        $this->view->addTemplate("user");
    }

    /*
      abstract public function create();
      abstract public function delete();
      abstract public function show();
      abstract public function edit();
     * 
     */
}

?>
