var path = require('path');
var webpack = require('webpack');

module.exports = {
  entry: [
    './src/renderer/index'
  ],
  output: {
      path: path.join(__dirname, "static"),
      filename: "index.js",
  },
  resolveLoader: {
    modulesDirectories: ['node_modules']
  },
  plugins: [
    new webpack.DefinePlugin({
      "process.env": {
        NODE_ENV: JSON.stringify("production")
      }
    }),
    new webpack.IgnorePlugin(/vertx/),
    new webpack.IgnorePlugin(/un~$/),
    new webpack.optimize.DedupePlugin(),
    new webpack.optimize.UglifyJsPlugin({noCopyright:true,nc:true,"no-copyright":true,compress:{warnings:false}}),
  ],
  resolve: {
    extensions: ['', '.js', '.cjsx', '.coffee', '.less', '.ttf', '.eot', '.woff'],
    modulesDirectories:[
      'node_modules',
      'bower_components'
    ]
  },
  
  /*
  externals:{
    "jquery": "var jQuery",
    "$"     : "var jQuery"
  },
  */

  module: {
    loaders: [
      { test: /\.css$/, loaders: ['style', 'css']},
      { test: /\.less/, loader: "style!css!less"},
      { test: /\.cjsx$/, loaders: ['coffee', 'cjsx']},
      { test: /\.(jpg|png|gif|svg)/, loader: 'file-loader'},
      { test: /\.coffee$/, loader: 'coffee' },
      { test: /\.(eot|ttf|woff)/, loader: 'file-loader'}
    ]
  }
}
