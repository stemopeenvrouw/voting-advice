# First get the sheet with the polls
(
	def round: . + 0.5 | floor;
	.sheets[1].data[0].rowData |
	map(
		select(.values[0].userEnteredValue.numberValue? | tonumber?) | {
			listid: .values[0].userEnteredValue.numberValue,
			poll: ((.values[2:-1] |map(.userEnteredValue.numberValue) |add) / (.values[2:-1] |length) |round),
		}
	)
) +
# First get the first sheet [0] with the list identifiers in the first column [0],
# names in the second [1], polling values [10], program urls [13].
(
	def round: . + 0.5 | floor;
	.sheets[0].data[0].rowData |
	map(
		select(.values[0].userEnteredValue.numberValue? | tonumber?) | {
			listid: .values[0].userEnteredValue.numberValue,
			listname: .values[1].userEnteredValue.stringValue,
			program: (.values[12].userEnteredValue.stringValue |
				if (contains("http")?) then . else null end)
		}
	)
) +
# Add to this array all sheets that start with a number, using this as listid
# Skip the header row [0] and interpret the rest as candidate data.
(
	.sheets | map(
		.listid = (.properties.title|split(" ")[0] | tonumber?) | {
			listid,
			candidates: .data[0].rowData[1:] | map({
				candidateid: .values[0].userEnteredValue.numberValue,
				name: .values[1].userEnteredValue.stringValue,
				gender: .values[2].userEnteredValue.stringValue,
				bio: .values[3].userEnteredValue.stringValue,
				instagram: .values[4].userEnteredValue.stringValue,
				linkedin: .values[5].userEnteredValue.stringValue,
				twitter: .values[6].userEnteredValue.stringValue,
				facebook: .values[7].userEnteredValue.stringValue
			})
		}
	)
) |
# Group and combine the list information with the candidate data.
group_by(.listid) |
map(
  .[0] + .[1] + {
		candidates: .[2].candidates
	}
)
