class Haplocheirus::Client

  # ==== Parameters
  # service<ThriftClient>
  #
  def initialize(service)
    @service = service
  end

  # Appends an entry to a set of timelines given by
  # timeline_ids. Appends will do nothing if the timeline has not been
  # created using #store.
  #
  # ==== Parameters
  # entry
  # timeline_ids<Array[String]>
  #
  def append(entry, timeline_ids)
    @service.append entry, timeline_ids
  end

  # Removes an entry from a set of timlines given by timeline_ids
  #
  # ==== Paramaters
  # entry
  # timeline_ids<Array[String]>
  #
  def remove(entry, timeline_ids)
    @service.remove entry, timeline_ids
  end

  # Gets entries on the timeline given by timeline_id, optionally
  # beginning at offset and limited by length. Timelines are stored in
  # recency order - an offset of 0 is the latest entry.
  #
  # ==== Parameters
  # timeline_id<String>
  # offset<Integer>
  # length<Integer>
  # dedupe<Boolean>:: Optional. Defaults to false.
  #
  def get(timeline_id, offset, length, dedupe = false)
    @service.get timeline_id, offset, length, dedupe
  rescue Thrift::ApplicationException
    []
  end

  # Gets a range of entries from the timeline given by timeline_id
  # since from_id (exclusive). This may include entries that were inserted out
  # of order. from_id is treated as a prefix.
  #
  # ==== Parameters
  # timeline_id<String>
  # from_id<Integer>
  # dedupe<Integer>:: Optional. Defaults to false.
  #
  def since(timeline_id, from_id, dedupe = false)
    @service.get_since timeline_id, from_id, dedupe
  rescue Thrift::ApplicationException => e
    []
  end

  # Atomically stores a set of entries into a timeline given by
  # timeline_id. The entries are stored in the order provided.
  #
  # ==== Parameters
  # timeline_id<String>
  # entries<Array>
  #
  def store(timeline_id, entries)
    @service.store timeline_id, entries
  end

  # Returns the intersection of entries with the current contents of
  # the timeline given by timeline_id. Returns an empty array if the
  # timeline_id does not exist.
  #
  # ==== Parameters
  # timeline_id<String>
  # entries<Array>
  #
  def filter(timeline_id, *entries)
    @service.filter timeline_id, entries.flatten
  rescue Thrift::ApplicationException
    []
  end

  # Merges the entries into the timeline given by timeline_id. Merges
  # will do nothing if the timeline hasn't been created using #store.
  #
  # ==== Parameters
  # timeline_id<String>
  # entries<Array>
  #
  def merge(timeline_id, entries)
    @service.merge timeline_id, entries
  end

  # Remove a list of entries from a timeline. Unmerges will do nothing
  # if the timeline hasn't been created using #store.
  #
  # ==== Parameters
  # timeline_id<String>
  # entries<Array>
  #
  def unmerge(timeline_id, entries)
    @service.unmerge timeline_id, entries
  end

  # Removes the timeline from the backend store
  #
  # ==== Parameters
  # timeline_id<String>
  #
  def delete(timeline_id)
    @service.delete timeline_id
  end
end
