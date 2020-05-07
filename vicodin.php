
     <?php
         
         include 'docheader.php';
         
    $servername = "127.0.0.1";
    $username = "root";
    $password = "Br@nd0np";
    $dbname = "DocOffice";
         
    // Create connection
    $conn = mysqli_connect($servername, $username, $password);
    // Check connection
    if (!$conn) {
        die("Connection failed: " . $conn->connect_error);
    }
         print("These are all the doctors who have prescribes Vicodin to their patients");
         
         mysqli_select_db($conn, $dbname) or die("Unable to select database $dbname");
         
         
         $sql = "SELECT doc_fname, doc_lname FROM DOCTOR WHERE docId in (SELECT doc_Id from PRESCRIPTION where scriptname = 'Vicodin');";
         
         $result = mysqli_query($conn,$sql);
         print "<pre>";
         print "<table align=center border=1>";
         print "<tr><td>First Name </td><td> Last Name</td>";
         
         while($row = mysqli_fetch_array($result, MYSQLI_BOTH))
         {
         print "<tr><td>$row[doc_fname] </td><td> $row[doc_lname] </td></tr>    ";
        }
         print "</table>";
         print "</pre>";
         mysqli_free_result($result);
         mysqli_close($conn);
         ?>
         </center>
