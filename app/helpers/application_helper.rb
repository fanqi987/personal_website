module ApplicationHelper

  def getWillPaginateOptions
    {next_label: "下一页 →",
     previous_label: "← 上一页",
     style: "text-align:center;display:block;",
     id: "pagination"
    }
  end

  def getCurrentCorrectTime(time)
    time.localtime.strftime("%Y-%m-%d %H:%M:%S")
  end

  def get_search_result(objects, start_time, end_time, search_word, table_name)
    #带搜索的索引
    p params
    @search_start_time, t_start_time = start_time, start_time
    @search_end_time, t_end_time = end_time, end_time
    @search_word, t_word = search_word, search_word

    # p @search_start_time
    # p @search_end_time
    # p @search_word

    t_start_time = Time.local(1970, 1, 1).strftime("%Y-%m-%d") if (@search_start_time.nil? || @search_start_time.empty?)
    t_end_time = (Time.now + 1.day).strftime("%Y-%m-%d") if (!@search_end_time || @search_end_time.empty?)
    t_word = "" if (!@search_word || @search_word.empty?)

    # p t_start_time
    # p t_end_time
    # p t_word

    # todo 调整为当地时间
    sql = ":table_name.'created_at' >= datetime(:start_time) AND :table_name.'created_at' <= datetime(:end_time) " +
        "AND "
    if table_name != "microposts"
      sql += "(:table_name.'content' like :word OR :table_name.'title' like :word)"
    else
      sql += ":table_name.'content' like :word"
    end

    objects = objects.where(
        sql,
        start_time: DateTime.parse(t_start_time) - 8.hours,
        end_time: DateTime.parse(t_end_time) - 8.hours,
        table_name: table_name,
        word: "%" + t_word + "%"
    )
    return objects
  end

  def getObjectIndex(object, objects)
    objects.each_with_index do |o, index|
      if object.eql? o
        @index = index
        @index_prev = @index == 0 ? nil : @index - 1
        @index_next = @index == objects.length - 1 ? nil : @index + 1
        return
      end
    end
  end

  def getObjectErrors(object)
    return object ? object.errors.collect {|k, v| v.is_a?(Array) ? v[0] : v}.to_s : ""
  end
end