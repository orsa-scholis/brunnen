import ApexCharts from 'apexcharts';

let _chart = null;
const _options = {
  series: [{}],
  chart: {
    type: 'bar',
    toolbar: {
      show: false
    }
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
    const { group_labels, group_values, min, max, vote_options } = data.averages;

    let options = { ..._options };
    options.series = [{
      name: '∅',
      data: group_values.map((group_value) => parseFloat(group_value).toFixed(2))
    }];
    options.xaxis.categories = group_labels;
    options.yaxis.min = min;
    options.yaxis.max = max;
    options.yaxis.tickAmount = max - min;
    options.yaxis.labels.formatter = (value) => vote_options;

    if (_chart == null) {
      _chart = new ApexCharts(document.querySelector('#chart'), options);
      _chart.render();
    } else {
      _chart.updateOptions(options);
    }
  },
};
