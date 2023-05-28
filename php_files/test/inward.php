<?php 
include "connect.php";


	
	$itemname=$_POST['itemname'];
    $rack_no=$_POST['rack_no'];
    $scanner=$_POST['scanner'];

    $quantity=1;
    $type='inward';
   
    
	$sqlQuery="INSERT INTO temp_inventory (itemname,quantity,rack_no,scanner,type) VALUES ('$itemname','$quantity','$rack_no','$scanner','$type')";
	$results= $conn ->query($sqlQuery);
 
  
    if($results>0)
    {
        echo "item added sucessfully";
    }       
    
    ?>