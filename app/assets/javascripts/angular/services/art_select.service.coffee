angular
  .module 'enapparte'
  .service 'ArtSelect', ['Art',
    class ArtSelect
      constructor: (@Art) ->
      	@items = []
      	@selected = null
      	@Art
          .query()
          .then (arts) =>
            @items = arts
  ]
