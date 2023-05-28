<?php 

include "connect.php";


$itemname=$_POST['itemname'];
$rack_no=$_POST['rackno'];
   


	
    $sql = "DELETE FROM temp_inventory where itemname='$itemname' and rack_no='$rack_no' LIMIT 1";
    $conn->query($sql);
   

   

   
    
?>