var path = require('path');
var webpack = require('webpack');

module.exports = {
  entry: [
    (__dirname + '/node_modules/webpack-dev-server/client?http://0.0.0.0:8080'),
    (__dirname + '/node_modules/webpack/hot/only-dev-server'),
    (__dirname + '/src/renderer/index')
  ],
  devtool: "eval",
  debug: false,
  output: {
    path: path.join(__dirname, "static"),
    filename: 'index.js',
    publicPath: "http://localhost:8080/"
  },
  resolveLoader: {
    modulesDirectories: [
      path.resolve(__dirname, 'node_modules'),
      'node_modules'
    ]
  },

  plugins: [
    new webpack.HotModuleReplacementPlugin({
      contentBase: "http://localhost:8080/",
      output:{publicPath: "http://localhost:8080/"}
    }),
    new webpack.NoErrorsPlugin(),
    new webpack.IgnorePlugin(/vertx/), // https://github.com/webpack/webpack/issues/353
    new webpack.ProvidePlugin({
      "_": "underscore"
    }),

  ],

  resolve: {
    extensions: ['', '.js', '.cjsx', '.coffee', '.less', '.ttf', '.eot', '.woff'],
    modulesDirectories:[
      path.resolve(__dirname, 'node_modules'),
      path.resolve(__dirname, 'bower_components'),
      'node_modules',
      'bower_components'
    ]
  },

  /*externals:{
    "jquery": "var jQuery",
    "$"     : "var jQuery"
  },*/

  module: {
    include: [
      path.resolve(__dirname, 'src')
    ],
    loaders: [
      { test: /\.css$/, loaders: ['style', 'css']},
      { test: /\.less/, loader: "style!css!less"},
      { test: /\.cjsx$/, loaders: ['react-hot', 'coffee', 'cjsx']},
      { test: /\.(jpg|png|gif|svg)/, loader: 'file-loader'},
      { test: /\.coffee$/, loader: 'coffee' },
      { test: /\.(eot|ttf|woff)/, loader: 'file-loader'}
    ]
  }
};
