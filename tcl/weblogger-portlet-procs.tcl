ad_library {

    Procedures to support the weblogger portlet

    @creation-date May 2003
    @author simon@bcuni.net

}

namespace eval weblogger_portlet {}

ad_proc -private weblogger_portlet::get_my_name {
} {
    return "weblogger_portlet"
}



ad_proc -private weblogger_portlet::my_package_key {
} {
    return "weblogger-portlet"
}



ad_proc -public weblogger_portlet::get_pretty_name {
} {
    return "Weblogger"
}



ad_proc -public weblogger_portlet::link {
} {
    return ""
}



ad_proc -public weblogger_portlet::add_self_to_page {
    {-portal_id:required}
    {-package_id:required}
    {-param_action:required}
} {
    Adds a weblogger PE to the given portal.
    
    @param portal_id The page to add self to
    @param package_id The community with the folder
    
    @return element_id The new element's id
} {
    return [portal::add_element_parameters \
                -portal_id $portal_id \
                -portlet_name [get_my_name] \
                -value $package_id \
                -force_region [parameter::get_from_package_key \
                                   -parameter "weblogger_portlet_force_region" \
                                   -package_key [my_package_key]] \
                -pretty_name [get_pretty_name] \
                -param_action $param_action
           ]
}



ad_proc -public weblogger_portlet::remove_self_from_page {
    {-portal_id:required}
    {-package_id:required}
} {
    Removes a weblogger PE from the given page or the package_id of the
    weblogger package from the portlet if there are others remaining
    
    @param portal_id The page to remove self from
    @param package_id
} {
    portal::remove_element_parameters \
        -portal_id $portal_id \
        -portlet_name [get_my_name] \
        -value $package_id
}



ad_proc -public weblogger_portlet::show {
    cf
} {
    portal::show_proc_helper \
        -package_key [my_package_key] \
        -config_list $cf \
        -template_src "weblogger-portlet"
}

