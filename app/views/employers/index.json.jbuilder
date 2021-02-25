# frozen_string_literal: true

json.array! @employers, partial: 'employers/employer', as: :employer
