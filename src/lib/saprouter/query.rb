# Copyright (c) 2014 SUSE LLC.
#  All Rights Reserved.

#  This program is free software; you can redistribute it and/or
#  modify it under the terms of version 2 or 3 of the GNU General
#  Public License as published by the Free Software Foundation.

#  This program is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.   See the
#  GNU General Public License for more details.

#  You should have received a copy of the GNU General Public License
#  along with this program; if not, contact SUSE LLC.

#  To contact SUSE about this file by physical or electronic mail,
#  you may find current contact information at www.suse.com

require "saprouter/entry"

module SapRouter
  # Wrapper for saprouter options.
  class Query

    FILTERS = [
      {name: :boot, arg: "--boot="},
      {name: :priority, arg: "--priority="},
      {name: :unit, arg: "--unit="},
      {name: :match}
    ]

    attr_reader :filters

    # Creates a new query based on some filters
    #
    # @param filters [Hash] valid keys are :boot, :priority, :unit and :match,
    #   the values must follow the format accepted by the corresponding
    #   saprouter argument.
    def initialize(filters = {})
      @filters = filters
    end

    # String with a list of arguments for saprouter
    def saprouter_args
      return @saprouter_args if @saprouter_args

      args = []
      # Add filters
      FILTERS.each do |filter|
        value = @filters[filter[:name]]
        args << "#{filter[:arg]}\"#{value}\"" if value
      end

      @saprouter_args = args.join(" ")
    end

    # Calls saprouter and returns an Array of Entry objects
    def entries
      Entry.all(saprouter_args)
    end

    def to_s
      "<filters: #{@filters}>"
    end
  end
end
