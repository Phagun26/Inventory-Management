<?php 

include "connect.php";

date_default_timezone_set('Asia/Kolkata');

    $date=date('Y-m-d');
	$sqlQuery="SELECT * FROM temp_inventory";

    
	$results=$conn->query($sqlQuery);

    if (mysqli_num_rows($results) > 0) {
        echo "done";
// output data of each row

    while($row = mysqli_fetch_assoc($results)) {
        $row1 = $row["itemname"];
        $row2 = $row["rack_no"];
        $row3 = $row["quantity"];
        $row4 = $row["scanner"];
        $row5 = $row["type"];
       
        $sqli= "SELECT * from history where itemname='$row1' AND rack_no='$row2' and scanner='$row4' and type='$row5' and date='$date'";
        $res=$conn->query($sqli);
        if(mysqli_num_rows($res)>0)
        {
            $sqlii= "UPDATE history SET quantity=quantity+1 where itemname='$row1' AND rack_no='$row2'and scanner='$row4' and type='$row5' and date='$date'";
            $conn->query($sqlii);
            
        }
        else
        {
            $sql1 = "INSERT INTO history(itemname,quantity,rack_no,scanner,type,date)
            VALUES ('$row1', '$row3', '$row2','$row4','$row5','$date');";
            $conn->query($sql1);

        }
            
            $sql2= "DELETE FROM temp_inventory where itemname='$row1' AND rack_no='$row2'and scanner='$row4' and type='$row5' LIMIT 1;";
            
            $conn->query($sql2);
            
        
    }
}




   
    
?>