<?php 
include "connect.php";
$bool=true;

$sqlQuery="SELECT * FROM inventory";
$results= $conn ->query($sqlQuery);
$list=array();
    if($results)
    {
        while($row=mysqli_fetch_assoc($results))
        {
            $list[]=$row;
        }
        
        echo json_encode($list);
        return json_encode($list);

    }


    ?>