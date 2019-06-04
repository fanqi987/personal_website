module MicropostsHelper

  def getSecretIPName name
    # p name
    if name =~ /(2(5[0-5]{1}|[0-4]\d{1})|[0-1]?\d{1,2})(\.(2(5[0-5]{1}|[0-4]\d{1})|[0-1]?\d{1,2})){3}/
      tname = name.split(".")
      tname[tname.length-1]="*"
      # p tname.join('.')
      tname.join('.')
    else
      name
    end
  end
end
