command: """
  python iCloud.widget/lib/fetchData.py
"""

refreshFrequency: '2h'

render: (output) -> """
<div class="storage-chart"></div>
"""

style: """
@import url(iCloud.widget/lib/style.css)
"""

update: (output, domEl) ->
  data = JSON.parse(output)

  bytesTotal = data.storageUsageInfo.totalStorageInBytes
  bytesParsed = 0

  chart = document.getElementsByClassName('storage-chart')[0]

  calcWidth = (byte) ->
    bytesParsed += byte
    Math.round(byte/bytesTotal * 100)

  contrast = (colour) ->
    bigint = parseInt(colour, 16)
    r = bigint >> 16 & 255
    g = bigint >> 8 & 255
    b = bigint & 255
    n = (.299 * r + .587 * g  + .114 * b) / 255
    if n > .7 then '' else if n < .5 then 'lightText' else 'darkText'

  checkWidth = (text, width) ->
    canvas = document.createElement('canvas')
    context = canvas.getContext('2d')
    context.font = '13px sans-serif'
    metrics = context.measureText(text)
    canvas = null
    if metrics.width < width/100 * chart.offsetWidth then text else ''

  fileSize = (bytes) ->
    i = Math.floor( Math.log(bytes) / Math.log(1024) );
    ( bytes / Math.pow(1024, i) ).toFixed(2) * 1 + ' ' + ['B', 'kB', 'MB', 'GB', 'TB'][i]

  template = (_class, width, colour, text) -> "<div class='item #{_class}' style='width:#{width}%; background-color:##{colour}'>#{text}</div>"

  chart.innerHTML = ''

  data.storageUsageByMedia.forEach (item) ->
    width = calcWidth(item.usageInBytes)
    chart.innerHTML += template contrast(item.displayColor), width, item.displayColor, checkWidth(item.displayLabel,width)

  bytesLeft = bytesTotal - bytesParsed
  width = calcWidth(bytesLeft)
  chart.innerHTML += template 'darkText', width, 'fff', checkWidth((fileSize bytesLeft),width)