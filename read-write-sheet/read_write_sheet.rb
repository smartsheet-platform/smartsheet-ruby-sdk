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
  row.cells.find {|cell| cell.column_id == column_id}
end

def get_cell_by_column_name(row, column_name, column_map)
  get_cell_by_column(row, column_map[column_name])
end

def build_update_complete_row(row, column_map)
  status_cell = get_cell_by_column_name(row, 'Status', column_map)
  remaining_cell = get_cell_by_column_name(row, 'Remaining', column_map)

  if status_cell.display_value == 'Complete'
    unless remaining_cell.display_value == '0'
      puts "Updating row #{row.row_number}"
      row_update(row.id, remaining_cell.column_id, 0)
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

def update_complete_rows(sheet_id, client)
  sheet = client.sheets.get(sheet_id: sheet_id)

  update_rows_body = build_update_complete_rows_body(sheet)
  if update_rows_body.empty?
    puts 'No Update Required'
    return
  end

  client.sheets.rows.update(sheet_id: sheet.id, body: update_rows_body)
end

def load_config(config_name)
  file = File.open(config_name)

  JSON.load(file)
end


config = load_config('config.json')

client = Smartsheet::SmartsheetClient.new(token: config['token'])

begin
  update_complete_rows(config['sheet_id'], client)
rescue Smartsheet::API::ApiError => e
  puts "API returned error:"
  puts "\terror code: #{e.error_code}"
  puts "\tref id: #{e.ref_id}"
  puts "\tmessage: #{e.message}"
end





