--!strict

--[[
	The entry point for the Fusion library.
]]

local PubTypes = require(script.PubTypes)
local restrictRead = require(script.Utility.restrictRead)

export type StateObject<T> = PubTypes.StateObject<T>
export type CanBeState<T> = PubTypes.CanBeState<T>
export type Symbol = PubTypes.Symbol
export type State<T> = PubTypes.State<T>
export type Computed<T> = PubTypes.Computed<T>
export type ComputedPairs<K, V> = PubTypes.ComputedPairs<K, V>
export type Observer = PubTypes.Observer
export type Delay<T> = PubTypes.Delay<T>
export type Tween<T> = PubTypes.Tween<T>
export type Spring<T> = PubTypes.Spring<T>

type Fusion = {
	New: (className: string) -> ((propertyTable: PubTypes.PropertyTable) -> Instance),
	Children: PubTypes.ChildrenKey,
	OnEvent: (eventName: string) -> PubTypes.OnEventKey,
	OnChange: (propertyName: string) -> PubTypes.OnChangeKey,

	State: <T>(initialValue: T) -> State<T>,
	Computed: <T>(callback: () -> T) -> Computed<T>,
	ComputedPairs: <K, VI, VO>(inputTable: CanBeState<{[K]: VI}>, processor: (K, VI) -> VO, destructor: (VO) -> ()?) -> ComputedPairs<K, VO>,
	Observer: (watchedState: StateObject<any>) -> Observer,
  Delay: <T>(valueState: StateObject<T>, delayDuration: number) -> Delay<T>,

	Tween: <T>(goalState: StateObject<T>, tweenInfo: TweenInfo?) -> Tween<T>,
	Spring: <T>(goalState: StateObject<T>, speed: number?, damping: number?) -> Spring<T>
}

return restrictRead("Fusion", {
	New = require(script.Instances.New),
	Children = require(script.Instances.Children),
	OnEvent = require(script.Instances.OnEvent),
	OnChange = require(script.Instances.OnChange),

	Value = require(script.State.Value),
	Computed = require(script.State.Computed),
	ComputedPairs = require(script.State.ComputedPairs),
	Observer = require(script.State.Observer),
  Delay = require(script.State.Delay),

	Tween = require(script.Animation.Tween),
	Spring = require(script.Animation.Spring)
}) :: Fusion
