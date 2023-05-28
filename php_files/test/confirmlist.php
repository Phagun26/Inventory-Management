<?php 

include "connect.php";

$type='inward';
$type2='outward';
	
   


	$sqlQuery="SELECT * FROM temp_inventory where type='$type'";

    
	$results=$conn->query($sqlQuery);

    if (mysqli_num_rows($results) > 0) {
        echo "done";
// output data of each row

    while($row = mysqli_fetch_assoc($results)) {
        $row1 = $row["itemname"];
        $row2 = $row["rack_no"];
        $row3 = $row["quantity"];
       
        $sqli= "SELECT * from inventory where itemname='$row1' AND rack_no='$row2'";
        $res=$conn->query($sqli);
        if(mysqli_num_rows($res)>0)
        {
            $sqlii= "UPDATE inventory SET quantity=quantity+1 where itemname='$row1' AND rack_no='$row2'";
            $conn->query($sqlii);
            
        }
        else
        {
            $sql1 = "INSERT INTO inventory(itemname,quantity,rack_no)
            VALUES ('$row1', '$row3', '$row2');";
            $conn->query($sql1);

        }
            
            // $sql2= "DELETE FROM temp_inventory where itemname='$row1' AND rack_no='$row2' LIMIT 1;";
            
            // $conn->query($sql2);
            
        
    }
}


$sql="SELECT * FROM temp_inventory where type='$type2'";

    
$results1=$conn->query($sql);

if(mysqli_num_rows($results1)>0)
{
    while($row = mysqli_fetch_assoc($results1)) {
        
        $row1 = $row["itemname"];
        $row2 = $row["rack_no"];
        

        $sqli= "SELECT * from inventory where itemname='$row1' AND rack_no='$row2'";
        $res=$conn->query($sqli);
        if(mysqli_num_rows($res)>0)
        {
            $sqlii= "UPDATE inventory SET quantity=quantity-1 where itemname='$row1' AND rack_no='$row2'";
            $conn->query($sqlii);
            
        }
        else
        {
            $sql1 = "DELETE FROM inventory where itemname='$row1' AND rack_no='$row2' LIMIT 1;";
            $conn->query($sql1);

        }
       

            
            // $sql2= "DELETE FROM temp_inventory where itemname='$row1' AND rack_no='$row2' LIMIT 1;";
           
            // $conn->query($sql2);
            
        
    }

}


   
    
?>