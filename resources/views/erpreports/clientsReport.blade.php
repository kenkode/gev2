<html >

<head>

<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>


<style type="text/css">
*{
  font-size: 10px !important;
}

table {
  max-width: 100%;
  background-color: transparent;
}

table, tr, td, th, tbody, thead, tfoot {
          page-break-inside: avoid !important;
      }

table.data{
  border-collapse: collapse;
  border: 1px solid #BBB;
}

table.data th, table.data td{
  padding: 5px 10px;
  border: 1px solid #BBB;
}

th,td{
  padding: 2px 7px !important;
}

th {
  text-align: left;
}
.table {
  width: 100%;
   margin-bottom: 150px;
}
hr {
  margin-top: 1px;
  margin-bottom: 2px;
  border: 0;
  border-top: 2px dotted #eee;
}

body {
  font-family: "Helvetica Neue", Helvetica, Arial, sans-serif;
  font-size: 12px;
  line-height: 1.428571429;
  color: #333;
  background-color: #fff;


 @page { margin: 50px 30px; }
 .header { position: top; left: 0px; top: -150px; right: 0px; height: 100px;  text-align: center; }
 .content {margin-top: -100px; margin-bottom: -150px}
 .footer { position: fixed; left: 0px; bottom: -60px; right: 0px; height: 50px;  }
 .footer .page:after { content: counter(page, upper-roman); }



img#watermark{
  position: fixed;
  width: 100%;
  z-index: 10;
  opacity: 0.1;
}

</style>
  
  </head>


  <body>
    <?php
ini_set("memory_limit","120M");
if (!function_exists('asMoney'))   {
function asMoney($value) {
  return number_format($value, 2);
}
}

use App\Http\Models\Client;
?>
  <!-- <img src="{{ asset('public/uploads/logo/ADmzyppq2eza.png') }}" class="watermark"> -->
  <div class="header">
       <table >

      <tr>
       
        <td style="width:150px">

            <img src="{{asset('public/uploads/logo/'.$organization->logo)}}" alt="logo" width="50%">    
        </td>

        <td>
        <strong>
          {{ strtoupper($organization->name)}}
          </strong><br>
          {{ $organization->phone}}<br>
          {{ $organization->email}}<br> 
          {{ $organization->website}}<br>
          {{ $organization->address}}
       

        </td>
        

      </tr>


      <tr>

        <hr>
      </tr>



    </table>
   </div>



<div class="footer">
     <p class="page">Page <?php $PAGE_NUM; ?></p>
   </div>


	<div class="content" style='margin-top:0px;'>
   <!-- <div align="center"><strong>Clients Report as at {{date('d-M-Y')}}</strong></div><br> -->
   <div align="center"><strong>Clients Report as at {{date('d-M-Y')}}</strong></div><br>

   

    <table  border='1' cellspacing='0' cellpadding='0'>

      <tr>

        <th width='20'><strong># </strong></th>
        <th><strong>Name </strong></th>
        <th><strong>Email </strong></th>
        <th><strong>Phone </strong></th>
        <th><strong>Address </strong></th>
        <th><strong>Contact Person </strong></th>        
        <th><strong>Phone </strong></th>
        <th><strong>Type </strong></th>
        <th><strong>Balance </strong></th>
      </tr>
      <?php $i =1; ?>
      @foreach($clients as $client)
      <tr>
        <td width='20'>{{$i}}</td>
        <td> {{ $client->name }}</td>
        <td> {{ $client->email }}</td>
        <td> {{ $client->phone }}</td>
        <td> {{ $client->address}}</td>
        <td> {{ $client->contact_person }}</td>        
        <td> {{ $client->contact_person_phone }}</td>
        <td> {{ $client->type}}</td>
        <td align="right"> {{ Client::due($client->id)}}</td>
        </tr>
      <?php $i++; ?>
   
    @endforeach

     

    </table>

<br><br>

   
</div>


</body>

</html>



