
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
         print ("Doctor Robert Stevens is retiring. If your name is on this list, it means you will be transfered over to a new doctor.\n\n");
         
         mysqli_select_db($conn, $dbname) or die("Unable to select database $dbname");
         
         
         $sql = "SELECT phone, pat_fname, pat_lname FROM PATIENT WHERE patId in (SELECT pat_Id from SEEN where doc_Id = 'FR9999');";
         
         $result = mysqli_query($conn,$sql);
         print "<pre>";
         print "<table align=center border=1>";
         print "<tr><td>Phone No. </td><td> First Name </td><td> Last Name </td>";
         while($row = mysqli_fetch_array($result, MYSQLI_BOTH))
         {
         print "\n";
         print "<tr><td>$row[phone] </td><td> $row[pat_fname] </td><td> $row[pat_lname]  </td></tr>    ";
         }
         print "</table>";
         print "</pre>";
         mysqli_free_result($result);
         mysqli_close($conn);
         ?>
         </center>
