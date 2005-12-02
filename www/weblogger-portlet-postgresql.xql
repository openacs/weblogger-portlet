<?xml version="1.0"?>

<queryset>
<rdbms><type>postgresql</type><version>7.1</version></rdbms>

    <fullquery name="entries">
        <querytext>
		    select e.entry_id,
                           acs_object__name(apm_package__parent_id(e.package_id)) as parent_name,
                           (select site_node__url(site_nodes.node_id)
                               from site_nodes
                               where site_nodes.object_id = e.package_id) as base_url,
		           e.title,
		           e.content,
                           u.first_names as poster_first_names,
		           u.last_name as poster_last_name,
			   to_char(e.entry_date , 'HH24:MI') as posted_time_pretty,
                           p.package_id
		    from   apm_packages p left outer join 
                           pinds_blog_entries e on (e.package_id = p.package_id) join 
		           acs_objects o on (o.object_id = e.entry_id) join 
		           acs_users_all u on (u.user_id = o.creation_user)
		    where  p.package_id in ([join $list_of_package_ids ", "])
		    and    e.entry_date > current_timestamp - interval '$num_days_shown days'
		    and    e.draft_p = 'f'
		    and    e.deleted_p = 'f'
		    order  by p.package_id asc, e.entry_date desc, e.entry_date desc
        </querytext>
    </fullquery>

    <fullquery name="delete_item">
          <querytext>
            update na_items set deleted_p = '1' where item_id = :delete_id
          </querytext>
    </fullquery>

</queryset>
