<!DOCTYPE HTML>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
		<title>Highcharts Example</title>

		<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.8.2/jquery.min.js"></script>
		<style type="text/css">
#container, #sliders {
    min-width: 310px; 
    max-width: 800px;
    margin: 0 auto;
}
#container {
    height: 400px; 
}
		</style>
		<script type="text/javascript">
		var lin=${lin};
		var pie=${pie};
		var area=${area};
		var column=${column};
		var c3dcolumn=${c3dcolumn};
		$(function () {
		    $('#lin').highcharts(lin);
		    $('#pie').highcharts(pie);
		    $('#area').highcharts(area);
		    $('#column').highcharts(column);
       });
	   <!---->
	   var chart = new Highcharts.Chart(c3dcolumn);

	    function showValues() {
	        $('#alpha-value').html(chart.options.chart.options3d.alpha);
	        $('#beta-value').html(chart.options.chart.options3d.beta);
	        $('#depth-value').html(chart.options.chart.options3d.depth);
	    }

	    // Activate the sliders
	    $('#sliders input').on('input change', function () {
	        chart.options.chart.options3d[this.id] = this.value;
	        showValues();
	        chart.redraw(false);
	    });

	    showValues();
		
		</script>
	</head>
	<body>
<script src="https://code.highcharts.com/highcharts.js"></script>
<script src="https://code.highcharts.com/highcharts-3d.js"></script>
<script src="https://code.highcharts.com/modules/exporting.js"></script>

<table>
  <tr><td><div id="lin"></div></td><td><div id="column"></div></td> </tr>
  <tr><td><div id="pie"></div></td><td></td></tr>
  <tr><td><div id="area"></div></td><td></td> </tr>
  
</table>
 
    
        	  
 
	</body>
</html>
