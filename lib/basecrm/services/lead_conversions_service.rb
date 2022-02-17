# WARNING: This code is auto-generated from the BaseCRM API Discovery JSON Schema

module BaseCRM
  class LeadConversionsService
    OPTS_KEYS_TO_PERSIST = Set[:lead_id, :organization_id]

    def initialize(client)
      @client = client
    end

    # Retrieve all conversions
    #
    # get '/lead_conversions'
    #
    # If you want to use filtering or sorting (see #where).
    # @return [Enumerable] Paginated resource you can use to iterate over all the resources.
    def all
      PaginatedResource.new(self)
    end

    # Retrieve all conversions
    #
    # get '/lead_conversions'
    #
    # Returns all lead conversions available to the user according to the parameters provided
    #
    # @param options [Hash] Search options
    # @option options [String] :ids Comma-separated list of lead source IDs to be returned in a request.
    # @option options [String] :name Name of the source to search for. This parameter is used in a strict sense.
    # @option options [Integer] :page (1) Page number to start from. Page numbering starts at 1, and omitting the `page` parameter will return the first page.
    # @option options [Integer] :per_page (25) Number of records to return per page. The default limit is *25* and the maximum number that can be returned is *100*.
    # @option options [String] :sort_by (id:asc) A field to sort by. The **default** ordering is **ascending**. If you want to change the sort order to descending, append `:desc` to the field e.g. `sort_by=name:desc`.
    # @return [Array<LeadConversion>] The list of LeadConversions for the first page, unless otherwise specified.
    def where(options = {})
      _, _, root = @client.get("/lead_conversions", options)

      root[:items].map{ |item| LeadConversion.new(item[:data]) }
    end


    # Create a new source
    #
    # post '/lead_conversions'
    #
    # Creates a new source
    # <figure class="notice">
    # Conversion's name **must** be unique
    # </figure>
    #
    # @param lead_source [LeadConversion, Hash] Either object of the LeadConversion type or Hash. This object's attributes describe the object to be created.
    # @return [LeadConversion] The resulting object represting created resource.
    def create(lead_source)
      validate_type!(lead_source)

      attributes = sanitize(lead_source)
      _, _, root = @client.post("/lead_conversions", attributes)

      LeadConversion.new(root[:data])
    end


    # Retrieve a single source
    #
    # get '/lead_conversions/{id}'
    #
    # Returns a single source available to the user by the provided id
    # If a source with the supplied unique identifier does not exist it returns an error
    #
    # @param id [Integer] Unique identifier of a LeadConversion
    # @return [LeadConversion] Searched resource object.
    def find(id)
      _, _, root = @client.get("/lead_conversions/#{id}")

      LeadConversion.new(root[:data])
    end


    # Update a source
    #
    # put '/lead_conversions/{id}'
    #
    # Updates source information
    # If the specified source does not exist, the request will return an error
    # <figure class="notice">
    # If you want to update a source, you **must** make sure source's name is unique
    # </figure>
    #
    # @param lead_source [LeadConversion, Hash] Either object of the LeadConversion type or Hash. This object's attributes describe the object to be updated.
    # @return [LeadConversion] The resulting object represting updated resource.
    def update(lead_source)
      validate_type!(lead_source)
      params = extract_params!(lead_source, :id)
      id = params[:id]

      attributes = sanitize(lead_source)
      _, _, root = @client.put("/lead_conversions/#{id}", attributes)

      LeadConversion.new(root[:data])
    end


    # Delete a source
    #
    # delete '/lead_conversions/{id}'
    #
    # Delete an existing source
    # If the specified source does not exist, the request will return an error
    # This operation cannot be undone
    #
    # @param id [Integer] Unique identifier of a LeadConversion
    # @return [Boolean] Status of the operation.
    def destroy(id)
      status, _, _ = @client.delete("/lead_conversions/#{id}")
      status == 204
    end


  private
    def validate_type!(lead_source)
      raise TypeError unless lead_source.is_a?(LeadConversion) || lead_source.is_a?(Hash)
    end

    def extract_params!(lead_source, *args)
      params = lead_source.to_h.select{ |k, _| args.include?(k) }
      raise ArgumentError, "one of required attributes is missing. Expected: #{args.join(',')}" if params.count != args.length
      params
    end

    def sanitize(lead_source)
      lead_source.to_h.select { |k, _| OPTS_KEYS_TO_PERSIST.include?(k) }
    end
  end
end
