require 'lib/models'
require 'csv'

# Before running this script with a CSV file, prepare it so:
#   - There is only a single line of column headings on the first line of the file
#   - There are no spaces before or after the column headings
#   - The column headings correspond with the key names in the columns{} hash below
#   - The data starts on line 2

columns = 
  { 
    'ID' 					 => nil,
    'Issued_Date'     		 => nil,
    'Issued_Time'   		 => nil,
    'Street'   				 => nil,
    'Infraction_Code'     	 => nil,
	'Current_Status'     	 => nil,
	'Next_Status	'     	 => nil,
	'Issued_By'     		 => nil,
	'Payment_Made'			 => nil.
	'Payment_Amount'		 => nil,
   }
  
count = 0

if ARGV[0].nil?
  puts "Specify the filename of the CSV file to import on the command line"
  exit
end

date_format = ARGV[1].upcase

if date_format != 'DMY' && date_format != 'MDY'
  puts "Specify the date format as DMY or MDY as the second argument on the command line"
  exit
end

CSV::Reader.parse(File.open(ARGV[0], 'rb')) do |row|

    count += 1
    
    if (count > 1) # skip first line that doesn't contain data
      
      p row
      
      dt = row[columns['Updated']].strip.split('/')

      # Date.new takes YMD params
      if date_format == 'DMY'
        d = Date.new(dt[2].to_i, dt[1].to_i, dt[0].to_i) 
      elsif date_format == 'MDY'
        d = Date.new(dt[2].to_i, dt[0].to_i, dt[1].to_i)
      elsif date_format == 'YMD'
        d = Date.new(dt[0].to_i, dt[1].to_i, dt[2].to_i)
      end
      
      payment = Payment.first_or_new(
        'Issued_By' =>  CEO,
        'ID' => TICKET,
        'amount' => row[columns['Amount']].strip.gsub(/,/, ''),
        'd' => d
      )
  
      unless payment.save
        puts "ERROR: Failed to save payment"
        payment.errors.each do |e|
          puts e
        end
      end
  else
    # Get the column headings
    position = 0

    for column in row
      columns[column] = position
      position += 1
    end
    puts columns.inspect
  end
end
