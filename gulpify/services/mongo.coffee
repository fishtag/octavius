Service = require "#{__base}/core/service"
MongoClient = require('mongodb').MongoClient

class MongoService extends Service
  events:
    'collections': 'collections'
    'clear': 'clear'

  initialize: ->
    @_initCache()
    if Config.data and Config.data.mongodb
      @start()
    else
      @callback(undefined, @)

  _initCache: ->
    @cache =
      collections: {}

  start: ->
    Gulpify::log.info "connecting to remote MongoDB Server"
    MongoClient.connect Config.data.mongodb.uri, (err, db) =>
      @db = db
      Gulpify::log.info "connection to MongoDB Server success"
      @callback(undefined, @)

  collections: (options) ->
    tasks = []
    _.each options.collections, (collection, key) =>
      tasks.push @getCollection(collection)
    async.parallel tasks, (err, data) ->
      results = {}
      _.each data, (result) ->
        results = _.extend results, result
      options.callback undefined, results

  getCollection: (collection, callback) ->
    if @cache.collections[collection]
      return (callback) =>
        Gulpify::log.info "MongoDB: receiving data from local cache"
        callback(undefined, @cache.collections[collection])
    else
      return (callback) =>
        Gulpify::log.info "MongoDB: receiving data from remote server"
        result = {}
        @db.collection(collection).find().toArray (err, data) =>
          result[collection] = data
          @cache.collections[collection] = result
          callback undefined, result

  clear: (options = {}) ->
    @_initCache()
    options.callback('Cache successfull cleared') if options.callback

module.exports = MongoService