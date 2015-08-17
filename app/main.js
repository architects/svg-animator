require('coffee-script/register')

var webpack = require("webpack"),
    WebpackDevServer = require("webpack-dev-server"),
    path = require('path')

var start = require('./src/browser/main.coffee')

global.webpackConfig = require("./webpack.config.js")

global.APP_ROOT = __dirname

var devServer = function(options){
  options = options || {}
  
  if(options.entry){
    webpackConfig.entry = options.entry 
  }
  
  webpackConfig.resolve.fallback = [
    path.resolve(path.join(__dirname,'node_module'))
  ]

  var server = new WebpackDevServer(webpack(webpackConfig),{
        hot: true,
        watchDelay: 100,
        noInfo: true
      })

  server.listen(8080, "0.0.0.0", function(err){
    if(err){
      throw("Webpack Error")
    }
  })
}

start({
  devServer: devServer
})
