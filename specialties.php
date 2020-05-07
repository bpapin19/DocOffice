
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
        print("Here is a list of our doctors and their specialties.");
         
         mysqli_select_db($conn, $dbname) or die("Unable to select database $dbname");
         
         
         $sql = "SELECT doc_fname, doc_lname, specialty FROM DOCTOR, DOCTORSPECIALTY WHERE DOCTOR.docId = DOCTORSPECIALTY.doc_Id;";
         $result = mysqli_query($conn,$sql);
         print "<pre>";
         print "<table align=center border=1>";
         print "<tr><td>First Name </td><td>Last Name </td><td>Specialty </td>";
         while($row = mysqli_fetch_array($result, MYSQLI_BOTH))
         {
             print "<tr><td> $row[doc_fname] </td><td> $row[doc_lname] </td><td> $row[specialty] </td></tr>";
         }
         print "</table>";
         print "</pre>";
         mysqli_free_result($result);
         mysqli_close($conn);
         ?>
         </center>
