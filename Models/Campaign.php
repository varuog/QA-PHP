<?php

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
require_once 'Abstracts/AbstractContent.php';

/**
 * Description of Campaign
 * @author Gourav Sarkar
 */
class Campaign extends AbstractContent{
    
    const CAMPAIGN_TYPE_VISIT=1;
    
    //put your code here
    private $capital; //SENSITIVE
    private $targetTraffic;
    private $type; //Ad type like CPM, per register,per visit, per impression
    private $approve;
    //private $uniqueIpTimeSpan=86400;
    private $area;
    private $title;
    
    
    public function __construct() {
        parent::__construct();
        
        $this->area=array();
    }
    
    public function setTitle($title)
    {
        $this->title=$title;
    }
    public function getTitle()
    {
        return $this->title;
    }
    
    public function setArea($area)
    {
        $this->area= $area;
    }
    public function getArea()
    {
        return $this->title;
    }
    
    
    public function setAprrove($apr)
    {
        $this->approve=$apr;
    }
    
    public function getApprove()
    {
        return $this->approve;
    }
    
    public function setCapital($fund)
    {
        //Must be string and numeric
        $this->capital=$fund;
        
    }
    public function getCapital()
    {
        return $this->capital;
    }
    
    public function setTargetTraffic($expTraffic)
    {
        $this->targetTraffic=$expTraffic;
        
    }
    public function getTargetTraffic()
    {
        return $this->targetTraffic;
    }
}

?>
