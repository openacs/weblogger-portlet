# www/weblogger-portlet.tcl
ad_page_contract {
    The display logic for the weblogger portlet

    @author Simon Carstensen (simon@bcuni.net)
} -properties {
    
}

array set config $cf
set user_id [ad_conn user_id]
set list_of_package_ids $config(package_id)

if {[llength $list_of_package_ids] > 1} {
    # We have a problem!
    return -code error "There should be only one instance of weblogger for admin purposes"
}        

set package_id [lindex $list_of_package_ids 0]        

set url [lindex [site_node::get_url_from_object_id -object_id $package_id] 0]

ad_return_template 
