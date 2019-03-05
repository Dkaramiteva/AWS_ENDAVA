<?php
error_reporting(E_ALL);
ini_set('display_errors', 1);
// connect to the database
$con = mysqli_connect('172.31.45.178:3306','elastic1','oag4Chai','prices')
or die(mysqli_error($con));
// select a database:
mysqli_select_db($con, 'prices')
or die("Could not select a database.");
// build query:
$sql = "SELECT name, price_usd_lb FROM metals";
// execute query:
$result = mysqli_query($con,$sql)
or die('A error occurred: ' . mysqli_error($con));
// get result count:
$count = mysqli_num_rows($result);
print "<h3>$count metal prices available</h3>";
print "<table>";
print "<tr><th>Name</th><th>Price (USD/lb)</th></tr>";
// fetch results:
while ($row = mysqli_fetch_assoc($result)) {
$name = $row['name'];
$price = $row["price_usd_lb"];
print "<tr><td><strong>$name</strong></td><td>$price</td></tr>";
}
print "</table>";
?>
