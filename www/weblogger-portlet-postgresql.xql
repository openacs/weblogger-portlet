<?xml version="1.0"?>

<queryset>
<rdbms><type>postgresql</type><version>7.1</version></rdbms>

    <fullquery name="entries">
        <querytext>
		    select entry_id,
                           acs_object__name(apm_package__parent_id(e.package_id)) as parent_name,
                           (select site_node__url(site_nodes.node_id)
                               from site_nodes
                               where site_nodes.object_id = e.package_id) as base_url,
		           title,
		           content,
                           p.first_names as poster_first_names,
		           p.last_name as poster_last_name,
			   to_char(posted_date , 'HH24:MI') as posted_time_pretty,
                           package_id
		    from   pinds_blog_entries e join 
		           acs_objects o on (o.object_id = e.entry_id) join 
		           persons p on (p.person_id = o.creation_user)
		    where  package_id in ([join $list_of_package_ids ", "])
		    and    entry_date > current_timestamp - interval '30 days'
		    and    draft_p = 'f'
		    and    deleted_p = 'f'
		    order  by entry_date desc, posted_date desc
        </querytext>
    </fullquery>

    <fullquery name="delete_item">
          <querytext>
            update na_items set deleted_p = '1' where item_id = :delete_id
          </querytext>
    </fullquery>

</queryset>
