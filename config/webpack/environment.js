const { environment } = require('@rails/webpacker')
const { join } = require('path')
const webpack = require('webpack')
const prod = process.env.NODE_ENV === 'production'
const root = join(__dirname, '../../app/javascript')
const r = (p) => join(root, p)
environment.plugins.prepend('DefineConstant', new webpack.DefinePlugin({
  __DEV__: !prod,
  __PROD__: prod
}))


environment.config.merge({
  resolve: {
    alias: {
      '~': root,
      '~components': r('./components'),
      '~metronic': r('./components/third-party/metronic'),
      '~layouts': r('./layouts'),
      '~packs': r('./packs'),
      '~pages': r('./pages'),
      '~services': r('./services'),
      '~store': r('./store'),
      '~utils': r('./utils')
    }
  }
})


module.exports = environment
