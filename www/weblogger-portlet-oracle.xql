<?xml version="1.0"?>

<queryset>
<rdbms><type>oracle</type><version>8.1.6</version></rdbms>

    <fullquery name="entries">
        <querytext>
		    select e.entry_id,
                           acs_object.name(apm_package.parent_id(p.package_id)) as parent_name,
                           (select site_node.url(site_nodes.node_id)
                            from   site_nodes
                            where  site_nodes.object_id = p.package_id) as base_url,
		           e.title,
                           e.content,
		           u.first_names as poster_first_names,
		           u.last_name as poster_last_name,
		           to_char(e.posted_date , 'HH24:MI') as posted_time_pretty,
                           p.package_id
		    from   apm_packages p,
                           pinds_blog_entries e,
		           acs_objects o,
		           acs_users_all u
		    where  p.package_id in ([join $list_of_package_ids ", "])
                    and    e.package_id (+) = p.package_id
                    and    o.object_id (+) = e.entry_id
		    and    u.user_id (+) = o.creation_user 
		    and    e.draft_p (+) = 'f'
		    and    e.deleted_p (+) = 'f'
		    order  by p.package_id asc, e.entry_date desc, e.posted_date desc
        </querytext>
    </fullquery>

    <fullquery name="delete_item">
          <querytext>
            update na_items set deleted_p = '1' where item_id = :delete_id
          </querytext>
    </fullquery>

</queryset>
