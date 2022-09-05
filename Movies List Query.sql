select
	mdi.title [Title],
	mdi.title_sort [Sorting Title],
	mdi.studio [Studio],
	mdi.content_rating [Content Rating],
	mdi.rating [Rating],
	mdi.audience_rating [Audience Rating],
	mi.width [Width],
	mi.height [Height],
	mi.container [Container],
	mi.video_codec [Video Codec],
	mi.audio_codec [Audio Codec]
from
	media_items mi
	inner join metadata_items mdi
		on mi.metadata_item_id = mdi.id
where
	mdi.metadata_type = 1
order by
	mdi.title_sort