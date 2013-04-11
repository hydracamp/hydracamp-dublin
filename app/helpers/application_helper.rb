module ApplicationHelper

    def date_format_helper args
        DateTime.iso8601( args[:document][args[:field]] ).strftime( "%Y-%m-%d %H:%M:%S" )
    end
end
