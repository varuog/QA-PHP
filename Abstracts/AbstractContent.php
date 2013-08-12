<?php

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

/*
 * @version PHP 5.4< will not use trait
 */
//require_once 'traits/CRUDLTrait.php';
//require_once 'traits/RenderbleTrait.php';

require_once 'Interfaces/CRUDLInterface.php';
require_once 'models/CRUDobject.php';

require_once 'Interfaces/DatabaseInteractbleInterface.php';
require_once 'interfaces/RenderbleInterface.php';

require_once 'models/SettingHandler.php';
require_once 'models/BaseObject.php';


require_once 'Models/XMLserialize.php';
require_once 'interfaces/XMLserializeble.php';
/**
 * Description of AbstractContent
 * Content behaviour
 * Must have id
 * Must have owner who beholds the authority of the object
 * Must have time of object spawn
 * Must have a Textual content
 * @author Gourav Sarkar
 * 
 * @issue Serializeble interface is breaking the serialization process in
 *  child methods-Fails session serialization
 */
abstract class AbstractContent extends BaseObject implements CRUDLInterface
, XMLSerializeble
,Serializable
, DatabaseInteractbleInterface {

    //put your code here
    //AbstractContent should be viewable so it has render trait
    /*
      use RenderbleTrait;
      use \CRUDLTrait;
     */



    /*
     * TESting
     */
    protected $id; /* @DATABASE */
    protected $user; //test
    protected $time;
    protected $content;
    protected $setting;
    protected $crud;
    protected $removed=false; //Every content can be removed softly

    public function __construct() {
        $this->user = new User();
        
        //$this->setting = SettingHandler::initSettingHandler($this);
        
        $this->crud = new CRUDobject($this);


        /*
         * make connection 
         * All abstractContent have DB intereaction
         * This part could be change to an implmentation later
         * It could be changed when caching technique applies
         * 
         * For now connection is set through setter method
         */
    }

    /** This function is used to insert data into DB 
     * Another implementetion of this method can be done with reflection
     * 
     */

    public function setRemoved($remove)
    {
        $this->crud->setFieldCache("removed");
        $this->removed=$remove;
    }
    public function getRemoved()
    {
        return $this->removed;
    }
    
    public function setID($id) {

        $this->crud->setFieldCache("id");
        $this->id = intval($id);
    }

    public function setTime($time = NULL) {
        $this->crud->setFieldCache("time");

        if (isset($time) && is_numeric($time)) {
            $this->time = $time;
            return null;
        }
        $this->time = time();
    }

    /*
     * Setter method for Owenr
     */

    public function setUser(User $owner=null) {
        $this->crud->setFieldCache("user");
        $this->user = $owner;
    }

    /* Setter method for content */

    public function setContent($content) {
        /*
         * Ensure Content is strin
         */
        if (is_string($content)) {
            $this->crud->setFieldCache("content");
            $this->content = $content;
            return true;
        }

        return false;
    }


    /* Getter methods to access private properties
     * 
     */

    public function getContent() {
        return $this->content;
    }

    public function getUser() {
        return $this->user;
    }

    public function getTime() {
        /*
         * 
         * Date formating

          $dateFormat=["inMinute"=>""
          ,"inDay"=>""
          ,"inPastDay"=>""
          ,"normal"=>""];
         */

        return $this->time;
    }

    public function getID() {
        return $this->id;
    }

    /*
     * Create link to get object data
     */
    /*
      public function serialize() {
      //Unset field cache
      //unset($this->fieldCache);
      //unset Connection
      //unset(AbstractContent::$connection);
      echo "serializing";
      return serialize($this);
      }

      public function unserialize($serialized)
      {
      //Revive connection
      AbstractContent::$connection=  DatabaseHandle::getConnection();
      return unserialize($serialized);
      }

      /*
     */

    public function create() {
        $e=$this->crud->create();
         return $e;
    }

    //public function delete();
    //public function update();
    public function read() {
        return $this->crud->read();
    }

    public function edit(DatabaseInteractbleInterface $tempObj) {
        return $this->crud->edit();
    }

    public function delete() {
        return $this->crud->delete();
    }

    public static function listing(DatabaseInteractbleInterface $reference) {
        return $this->crud->listing();
    }
    public function softRead()
    {
        return $this->crud->softRead();
    }


    
    public function xmlSerialize() {
        
        $writer=new XMLWriter();
        $writer->openMemory();
        
        $writer->startElement((string) $this);
            $xmlSer = new XMLSerialize($this);
            $writer->writeRaw($xmlSer->xmlSerialize());
        $writer->endElement();
        
        
        return $writer->outputMemory(true);
    }
    
    public function hasDependency()
    {
        return (bool) isset($this->dependency);
    }
    
    
    public function serialize() {
        unset($this->setting);
        
        return serialize($this);
    }
    
    public function unserialize($serialized) {
        static::__construct();
    }
    
    /*
     * @todo part of database interactble interface
     */
    public function getStrcuture()
    {
        
        array_filter(get_object_vars($this),function($property)
                                            {
            return $property instanceof DatabaseInteractbleInterface || !is_object($property);
                                            }
        
                                    );
    }
}

?>
