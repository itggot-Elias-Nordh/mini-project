def StudentList
    list = Dir["public/img/*"]
    students = []
    for s in list
        s.sub! "public/img", ""
        s.sub! ".jpg", ""
        s.sub! "/", ""
        students << s
    end
    return students
end


def ClassFix(students)
    name_hash = {}
    classes = []
    lastclass = nil
    for s in students
        s = s.gsub(/\s+/m, ' ').strip.split(" ")
        if lastclass != s[0]
            classes << s[0]
            lastclass = s[0]
        end
        classes = classes.uniq
    end


    namelist = []
    for s in classes
        for n in students
            n = n.gsub(/\s+/m, ' ').strip.split(" ")
            if s == n[0]
                namearr = n.reject.with_index { |_el, index| index == 0 }.join(" ")
                namelist << namearr
            end
        end
        name_hash[s] = namelist
        namelist = []
    end
    return name_hash
end



def getList()
   return ClassFix(StudentList())
end