require 'smartsheet/smartsheet_client'


def row_update(row_id, column_id, value)
  {
      id: row_id,
      cells: [{
                  columnId: column_id,
                  value: value
              }]
  }
end

def column_map(sheet)
  column_map = {}
  sheet.columns.each do |column|
    column_map[column.title] = column.id
  end

  column_map
end

def get_cell_by_column(row, column_id)
  row.cells.find {|cell| cell.columnId == column_id}
end

def get_cell_by_column_name(row, column_name, column_map)
  get_cell_by_column(row, column_map[column_name])
end

def build_update_complete_row(row, column_map)
  status_cell = get_cell_by_column_name(row, 'Status', column_map)
  remaining_cell = get_cell_by_column_name(row, 'Remaining', column_map)

  if status_cell.displayValue == 'Complete'
    unless remaining_cell.displayValue == '0'
      puts "Updating row #{row.rowNumber}"
      row_update(row.id, remaining_cell.columnId, 0)
    end
  end
end

def build_update_complete_rows_body(sheet)
  column_map = column_map(sheet)
  update_rows = []
  sheet.rows.each do |row|
    update_row = build_update_complete_row(row, column_map)
    update_rows.push(update_row) unless update_row.nil?
  end

  update_rows
end

def update_complete_rows(sheet, client)
  update_rows_body = build_update_complete_rows_body(sheet)
  if update_rows_body.empty?
    puts 'No Update Required'
    return
  end

  response = client.sheets.rows.update(sheet_id: sheet.id, body: update_rows_body)

  if response.success?
    puts 'Successfully Updated'
  else
    print 'Failed to update: '
    puts response.message
    exit 1
  end
end

def load_config(config_name)
  file = File.open(config_name)

  JSON.load(file)
end


config = load_config('config.json')

client = Smartsheet::SmartsheetClient.new(config['token'])

response = client.sheets.get(sheet_id: config['sheet_id'])

unless response.success?
  print "Failed to get sheet #{config['sheet_id']}: "
  puts response.message
  exit 1
end

sheet = response.result

update_complete_rows(sheet, client)
