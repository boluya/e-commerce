<%@ page import="java.util.Arrays" %>
<%@ page import="java.util.ArrayList" %>
  <!DOCTYPE html>
  <html lang="en">

  <head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
  </head>

  <body>
    <div style="width: 500px !important;">
      <canvas id="myChart"></canvas>
    </div>

    <% ArrayList<String> labelVals = new ArrayList<String>();
    ArrayList<Double> dataValues = new ArrayList<Double>();
      labelVals.add("\"" + "a" + "\"");
      labelVals.add("\"" + "b" + "\"");
      dataValues.add(1.1);
      dataValues.add(2.1);
      
      %>

      <% int[] a={7,6,5,4,3,2,1}; %>


      <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

      <script>
        const ctx = document.getElementById('myChart');
        const labels = <%out.println(Arrays.toString(labelVals.toArray()));%>;
        const data = {
          labels: labels,
          datasets: [{
            label: 'My First Dataset',
            data: <%out.println(Arrays.toString(dataValues.toArray()));%> ,
            backgroundColor: [
            'rgba(255, 99, 132, 0.2)',
            'rgba(255, 159, 64, 0.2)',
            'rgba(255, 205, 86, 0.2)',
            'rgba(75, 192, 192, 0.2)',
            'rgba(54, 162, 235, 0.2)',
            'rgba(153, 102, 255, 0.2)',
            'rgba(201, 203, 207, 0.2)'
          ],
            borderColor: [
            'rgb(255, 99, 132)',
            'rgb(255, 159, 64)',
            'rgb(255, 205, 86)',
            'rgb(75, 192, 192)',
            'rgb(54, 162, 235)',
            'rgb(153, 102, 255)',
            'rgb(201, 203, 207)'
          ],
            borderWidth: 1
		}]
	};

        const config = {
          type: 'bar',
          data: data,
          options: {
            scales: {
              y: {
                beginAtZero: true
              }
            }
          },
        };

        new Chart(ctx, config);
      </script>

  </body>

  </html>