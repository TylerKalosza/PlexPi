select
	mdi.title [Title],
	mdi.year [Year],
	mdi.content_rating [Content Rating],
	mdi.tags_star [Actor Tags],
	mi.container [Container],
	mi.video_codec [Video Codec],
	mi.audio_codec [Audio Codec],
	mi.width [Width],
	mi.height [Height],
	mdi.rating [Rating],
	mdi.audience_rating [Audience Rating],
	mdi.studio [Studio],
	mdi.title_sort [Sorting Title]
from
	media_items mi
	inner join metadata_items mdi
		on mi.metadata_item_id = mdi.id
where
	mdi.metadata_type = 1
order by
	mdi.title_sort
