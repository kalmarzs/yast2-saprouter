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

require "yast2-saprouter/query.rb"
require "yast2-saprouter/entry_presenter.rb"
require "delegate"

module SapRouter
  # Presenter for Query adding useful methods for the dialogs
  class QueryPresenter < SimpleDelegator

    include Yast::I18n
    extend Yast::I18n
    # To be used in class methods
    textdomain "saprouter"

    def initialize(args = {})
      # To be used in instance methods
      textdomain "saprouter"

      # Provides a default value for :boot
      # and ensures that it's always present and not nil
      query_args = args.dup
      query_args[:boot] = "0" unless args[:boot]

      query = Query.new(query_args)
      __setobj__(query)
    end

    # Original query
    def query
      __getobj__
    end

    # Decorated entries
    #
    # @return [Array<EntryPresenter]
    def entries
      query.entries.map {|entry| EntryPresenter.new(entry) }
    end

    # Fields to display for listing the entries
    #
    # @return [Array<Hash>] for each column a :label and a :method is provided
    def columns
      [
        {label: _("Type"), method: :source},
        {label: _("SNC name"), method: :source},
        {label: _("Src/Dest host"), method: :message},
        {label: _("Src/Dest host"), method: :message}
      ]
    end
  end
end
