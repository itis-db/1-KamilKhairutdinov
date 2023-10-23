with recursive activity_hierarchy as (
    select
        act.activityid as id,
        act.parentid,
        act.activitytypeid,
        act.code as activityid,
        at.name as activity_name,
        cast(at.name as VARCHAR) as hierarchy_path
    from activity as act
    join activitytype as at on at.activitytypeid = act.activitytypeid
    where act.parentid is null

    union

    select
        act.activityid as id,
        act.parentid,
        act.activitytypeid,
        act.code as activityid,
        at.name as activity_name,
        concat(h.hierarchy_path, ' -> ', at.name) as hierarchy_path
    from activity as act
    join activitytype as at on at.activitytypeid = act.activitytypeid
    join activity_hierarchy as h on act.parentid = h.id
)
select * from activity_hierarchy;
