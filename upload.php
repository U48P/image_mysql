<?php

    $db = mysqli_connect('localhost','root','','userdata');
    if (!db) {
        echo "Database connection failed";

    }

    $image = $_FILES['image'];
    //$name = $_POST['name'];


    $imagePath = 'upload/'.$image;
    $tmp_name = $_FILES['image'];




    
    move_uploaded_file($tmp_name, $imagePath);
    $db->query("INSERT INTO person (image) VALUES('".$image."') ");
    //db->query("insert into person (image) values('".$image."')");





    


?>    
