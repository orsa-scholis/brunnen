import ApexCharts from 'apexcharts'

let _chart = null;
const _options = {
  chart: {
    type: 'bar'
  },
  xaxis: {
    labels: {
      style: {
        fontSize: '22px'
      }
    }
  },
  yaxis: {
    labels: {
      style: {
        fontSize: '22px'
      }
    }
  },
  plotOptions: {
    bar: {
      columnWidth: '45%',
      distributed: true
    }
  },
  dataLabels: {
    enabled: false
  },
  legend: {
    show: false
  },
};

export const chart = {
  render(data) {
    const { group_labels, values, min, max } = data.averages;

    let options = _options;
    options.series = [{
      name: '∅',
      data: values
    }];
    options.xaxis.categories = group_labels;
    options.yaxis.min = min;
    options.yaxis.max = max;
    options.yaxis.formatter = (value) => {

    };

    if (_chart == null) {
      _chart = new ApexCharts(document.querySelector("#chart"), options);
      _chart.render();
    } else {
      _chart.updateOptions(options)
    }
  },
};
