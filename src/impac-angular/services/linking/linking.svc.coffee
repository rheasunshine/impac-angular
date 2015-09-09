#=======================================
# This provider service is designed to provide impac-angular with all it's vital methods & data,
# while internally keeping it's concerns as focused as possible.
# TODO: when this gets less varied.. split out into multiple, more specific providers.
#=======================================
angular
  .module('impac.services.linking', [])
  .provider('ImpacLinking', () ->
    provider = @
    #=======================================
    # Private Defaults
    #=======================================
    # Required data:
    links = {
      organizations: null,
      ssoSession: null
    }
    #=======================================
    # Public methods available in config
    #=======================================
    # Iterates over default links object and assigns values from configData with strict checking.
    provider.linkData = (configData)  ->
      _.forIn(links, (value, key) ->
        link = configData[key]
        unless link?
          throw "Missing core data (#{key}) to run impac-angular, please refer to impac.services.linking module or impac-angular README.md on required provider configurations."
        links[key] = link
      )
      return

    #=======================================
    _$get = () ->
      service = @
      #=======================================
      # Public methods available as service
      #=======================================

      service.getOrganizations = ->
        return links.organizations()

      service.getSsoSession = ->
        return links.ssoSession()

      return service
    # inject service dependencies here, and declare in _$get function args.
    _$get.$inject = [];
    # attach provider function onto the provider object
    provider.$get = _$get

    return provider

  )
