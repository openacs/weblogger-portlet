ad_library {
    Procedures for initializing service contracts etc. for the
    weblogger portlet package. Should only be executed 
    once upon installation.
    
    @creation-date 8 May 2003
    @author Simon Carstensen (simon@collaboraid.biz)
    @cvs-id $Id$
}


namespace eval weblogger_portlet {}
namespace eval weblogger_admin_portlet {}

ad_proc -private weblogger_portlet::after_install {} {
    Create the datasources needed by the weblogger portlet.
} {
    
    db_transaction {
	set ds_id [portal::datasource::new \
                   -name "weblogger_portlet" \
                   -description "Weblogger Portlet"]

	portal::datasource::set_def_param \
            -datasource_id $ds_id \
            -config_required_p t \
            -configured_p t \
            -key shadeable_p \
            -value t

	portal::datasource::set_def_param \
            -datasource_id $ds_id \
            -config_required_p t \
            -configured_p t \
            -key hideable_p \
            -value t

        portal::datasource::set_def_param \
            -datasource_id $ds_id \
            -config_required_p t \
            -configured_p t \
            -key user_editable_p \
            -value f

        portal::datasource::set_def_param \
            -datasource_id $ds_id \
            -config_required_p t \
            -configured_p t \
            -key shaded_p \
            -value f

        portal::datasource::set_def_param \
            -datasource_id $ds_id \
            -config_required_p t \
            -configured_p t \
            -key link_hideable_p \
            -value f

        portal::datasource::set_def_param \
            -datasource_id $ds_id \
            -config_required_p t \
            -configured_p f \
            -key package_id \
            -value ""

	register_portal_datasource_impl

        weblogger_admin_portlet::after_install

    }
}



ad_proc -private weblogger_portlet::register_portal_datasource_impl {} {
    Create the service contracts needed by the weblogger portlet.
} {
    set spec {
        name "weblogger_portlet"
	contract_name "portal_datasource"
	owner "weblogger-portlet"
        aliases {
	    GetMyName weblogger_portlet::get_my_name
	    GetPrettyName  weblogger_portlet::get_pretty_name
	    Link weblogger_portlet::link
	    AddSelfToPage weblogger_portlet::add_self_to_page
	    Show weblogger_portlet::show
	    Edit weblogger_portlet::edit
	    RemoveSelfFromPage weblogger_portlet::remove_self_from_page
        }
    }
    
    acs_sc::impl::new_from_spec -spec $spec
}



ad_proc -private weblogger_portlet::before_uninstall {} {
    Weblogger Portlet package uninstall proc
} {

    db_transaction {
        unregister_implementations
        
        weblogger_admin_portlet::uninstall
    }
}



ad_proc -private weblogger_portlet::unregister_implementations {} {
    Unregister service contract implementations
} {
    acs_sc::impl::delete \
        -contract_name "portal_datasource" \
        -impl_name "weblogger_portlet"
}



ad_proc -private weblogger_admin_portlet::after_install {} {
    Create the datasources needed by the weblogger portlet.
} {
    
    db_transaction {
	set ds_id [portal::datasource::new \
                   -name "weblogger_admin_portlet" \
                   -description "Weblogger Admin Portlet"]

	portal::datasource::set_def_param \
            -datasource_id $ds_id \
            -config_required_p t \
            -configured_p t \
            -key shadeable_p \
            -value f

	portal::datasource::set_def_param \
            -datasource_id $ds_id \
            -config_required_p t \
            -configured_p t \
            -key hideable_p \
            -value f

        portal::datasource::set_def_param \
            -datasource_id $ds_id \
            -config_required_p t \
            -configured_p t \
            -key user_editable_p \
            -value f

        portal::datasource::set_def_param \
            -datasource_id $ds_id \
            -config_required_p t \
            -configured_p t \
            -key shaded_p \
            -value f

        portal::datasource::set_def_param \
            -datasource_id $ds_id \
            -config_required_p t \
            -configured_p t \
            -key link_hideable_p \
            -value t

        portal::datasource::set_def_param \
            -datasource_id $ds_id \
            -config_required_p t \
            -configured_p f \
            -key package_id \
            -value ""

	register_portal_datasource_impl
    }
}



ad_proc -private weblogger_admin_portlet::register_portal_datasource_impl {} {
    Create the service contracts needed by the weblogger admin portlet.
} {
    set spec {
        name "weblogger_admin_portlet"
	contract_name "portal_datasource"
	owner "weblogger-portlet"
        aliases {
	    GetMyName weblogger_admin_portlet::get_my_name
	    GetPrettyName  weblogger_admin_portlet::get_pretty_name
	    Link weblogger_admin_portlet::link
	    AddSelfToPage weblogger_admin_portlet::add_self_to_page
	    Show weblogger_admin_portlet::show
	    Edit weblogger_admin_portlet::edit
	    RemoveSelfFromPage weblogger_admin_portlet::remove_self_from_page
        }
    }
    
    acs_sc::impl::new_from_spec -spec $spec
}



ad_proc -private weblogger_admin_portlet::uninstall {} {
    Weblogger Portlet package uninstall proc
} {
    unregister_implementations
}



ad_proc -private weblogger_admin_portlet::unregister_implementations {} {
    Unregister service contract implementations
} {
    acs_sc::impl::delete \
        -contract_name "portal_datasource" \
        -impl_name "weblogger_admin_portlet"
}
