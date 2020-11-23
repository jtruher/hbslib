#!/usr/bin/env ruby

require 'json'
require 'pp'
require 'base64'

class String
  def camel_case_lower
    self.split('_').inject([]){ |buffer,e| buffer.push(buffer.empty? ? e : e.capitalize) }.join
  end
end

final =
  """// swiftlint:disable all
extension BackgroundImage {

  #if !os(macOS)
  var image : UIImage {
    return UIImage.convertBase64StringToImage(imageBase64String: base64)
  }
  #endif
  
  var base64 : String {
    switch self {

"""

enum_list = []

Dir['backgrounds/**/*.png'].each do |img|
  img_data = Base64.encode64(File.read(img))
  img_data.gsub!('
', '')
  cleaned = img.gsub('.png', '').split('_')[1..-1].join('_')
  puts cleaned, img_data
  enum_list << cleaned
  final << "case .#{cleaned}:\nreturn \"#{img_data}\"\n"
end

final << " } \n } \n }"

puts final

# File.open('BackgroundImageExtras.swift', 'w') { |file| file.write(final) }

base_enum_file = """import Foundation
#if !os(macOS)
import UIKit
#endif
// swiftlint:disable all

enum BackgroundImage : String, CaseIterable {

    case #CASES#

    var name : String {
        return \"backgrounds_\(self.rawValue).png\"
    }
}
"""

base_enum_file.gsub!('#CASES#', enum_list.join(', '))
puts base_enum_file

base_enum_file << final

File.open('sources/hbslib/BackgroundImage.swift', 'w') { |file| file.write(base_enum_file) }
