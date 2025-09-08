#[starknet::contract]
pub mod sn_c1 {
    #[storage]
    struct Storage {}
}

#[derive(Drop, Serde, Clone)]
pub struct GameContextDetails {
    pub name: ByteArray,
    pub description: ByteArray,
    pub id: Option<u32>,
    pub context: Span<GameContext>,
}

#[derive(Drop, Serde, Clone)]
pub struct GameContext {
    pub name: ByteArray,
    pub value: ByteArray,
}

#[derive(Serde, Drop)]
pub struct M<> {
    #[key]
    pub k: felt252,
    pub v: felt252,
}

impl MDojoStore of dojo::storage::DojoStore<M> {
        fn dojo_serialize(self: @M, ref serialized: Array<felt252>) {
            dojo::storage::DojoStore::dojo_serialize(self.k, ref serialized);
dojo::storage::DojoStore::dojo_serialize(self.v, ref serialized);

        }
        fn dojo_deserialize(ref values: Span<felt252>) -> Option<M> {
            let k = dojo::storage::DojoStore::<felt252>::dojo_deserialize(ref values)?;
let v = dojo::storage::DojoStore::<felt252>::dojo_deserialize(ref values)?;

            Option::Some(M {
                k,
v
            })
        }
    }



impl MIntrospect of dojo::meta::introspect::Introspect<M> {
    #[inline(always)]
    fn size() -> Option<usize> {
        dojo::meta::introspect::Introspect::<felt252>::size()
    }
    #[inline(always)]
    fn layout() -> dojo::meta::Layout {
        dojo::meta::Layout::Struct(
            array![
                dojo::meta::FieldLayout {
                    selector: 578691550836206188651404750433984985630363913126316857592149308417275000080,
                    layout: dojo::meta::introspect::Introspect::<felt252>::layout(),
                },
            ]
                .span(),
        )
    }
    #[inline(always)]
    fn ty() -> dojo::meta::introspect::Ty {
        dojo::meta::introspect::Ty::Struct(
            dojo::meta::introspect::Struct {
                name: 'M',
                attrs: array![].span(),
                children: array![
                    dojo::meta::introspect::Member {
                        name: 'k',
                        attrs: array!['key'].span(),
                        ty: dojo::meta::introspect::Introspect::<felt252>::ty(),
                    },
                    dojo::meta::introspect::Member {
                        name: 'v',
                        attrs: array![].span(),
                        ty: dojo::meta::introspect::Introspect::<felt252>::ty(),
                    },
                ]
                    .span(),
            },
        )
    }
}


#[derive(Serde, Drop)]
pub struct MValue {
    pub v: felt252,
}
impl MValueDojoStore of dojo::storage::DojoStore<MValue> {
        fn dojo_serialize(self: @MValue, ref serialized: Array<felt252>) {
            dojo::storage::DojoStore::dojo_serialize(self.v, ref serialized);

        }
        fn dojo_deserialize(ref values: Span<felt252>) -> Option<MValue> {
            let v = dojo::storage::DojoStore::<felt252>::dojo_deserialize(ref values)?;

            Option::Some(MValue {
                v
            })
        }
    }



impl MValueIntrospect of dojo::meta::introspect::Introspect<MValue> {
    #[inline(always)]
    fn size() -> Option<usize> {
        dojo::meta::introspect::Introspect::<felt252>::size()
    }
    #[inline(always)]
    fn layout() -> dojo::meta::Layout {
        dojo::meta::Layout::Struct(
            array![
                dojo::meta::FieldLayout {
                    selector: 578691550836206188651404750433984985630363913126316857592149308417275000080,
                    layout: dojo::meta::introspect::Introspect::<felt252>::layout(),
                },
            ]
                .span(),
        )
    }
    #[inline(always)]
    fn ty() -> dojo::meta::introspect::Ty {
        dojo::meta::introspect::Ty::Struct(
            dojo::meta::introspect::Struct {
                name: 'MValue',
                attrs: array![].span(),
                children: array![
                    dojo::meta::introspect::Member {
                        name: 'v',
                        attrs: array![].span(),
                        ty: dojo::meta::introspect::Introspect::<felt252>::ty(),
                    },
                ]
                    .span(),
            },
        )
    }
}


type MKeyType = felt252;

pub impl MKeyParser of dojo::model::model::KeyParser<M, MKeyType> {
    #[inline(always)]
    fn parse_key(self: @M) -> MKeyType {
        *self.k
    }
}

impl MModelValueKey of dojo::model::model_value::ModelValueKey<MValue, MKeyType> {}

// Impl to get the static definition of a model
pub mod m_M_definition {
    use super::M;
    pub impl MDefinitionImpl<T> of dojo::model::ModelDefinition<T> {
        #[inline(always)]
        fn name() -> ByteArray {
            "M"
        }

        #[inline(always)]
        fn layout() -> dojo::meta::Layout {
            dojo::meta::Introspect::<M>::layout()
        }

        #[inline(always)]
        fn use_legacy_storage() -> bool {
            false
        }

        #[inline(always)]
        fn schema() -> dojo::meta::introspect::Struct {
            if let dojo::meta::introspect::Ty::Struct(s) = dojo::meta::Introspect::<M>::ty() {
                s
            } else {
                panic!("Model M: invalid schema.")
            }
        }

        #[inline(always)]
        fn size() -> Option<usize> {
            dojo::meta::Introspect::<M>::size()
        }
    }
}

pub impl MDefinition = m_M_definition::MDefinitionImpl<M>;
pub impl MModelValueDefinition = m_M_definition::MDefinitionImpl<MValue>;

pub impl MModelParser of dojo::model::model::ModelParser<M> {
    fn deserialize(ref keys: Span<felt252>, ref values: Span<felt252>) -> Option<M> {
        let k = core::serde::Serde::<felt252>::deserialize(ref keys)?;

        let v = dojo::storage::DojoStore::<felt252>::dojo_deserialize(ref values)?;

        Some(M { k, v })
    }
    fn serialize_keys(self: @M) -> Span<felt252> {
        let mut serialized = core::array::ArrayTrait::new();
        dojo::storage::DojoStore::dojo_serialize(self.k, ref serialized);

        core::array::ArrayTrait::span(@serialized)
    }
    fn serialize_values(self: @M) -> Span<felt252> {
        let mut serialized = core::array::ArrayTrait::new();
        dojo::storage::DojoStore::dojo_serialize(self.v, ref serialized);

        core::array::ArrayTrait::span(@serialized)
    }
}

pub impl MModelValueParser of dojo::model::model_value::ModelValueParser<MValue> {
    fn deserialize(ref values: Span<felt252>) -> Option<MValue> {
        dojo::storage::DojoStore::<MValue>::dojo_deserialize(ref values)
    }
    fn serialize_values(self: @MValue) -> Span<felt252> {
        let mut serialized = core::array::ArrayTrait::new();
        dojo::storage::DojoStore::dojo_serialize(self.v, ref serialized);

        core::array::ArrayTrait::span(@serialized)
    }
}

// Note that MDojoStore is implemented through the DojoStore derive attribute
// as any structs.

pub impl MModelImpl = dojo::model::model::ModelImpl<M>;
pub impl MModelValueImpl = dojo::model::model_value::ModelValueImpl<MValue>;

#[starknet::contract]
pub mod m_M {
    use super::{M, MValue};

    #[storage]
    struct Storage {}

    #[abi(embed_v0)]
    impl M__DojoDeployedModelImpl =
        dojo::model::component::IDeployedModelImpl<ContractState, M>;

    #[abi(embed_v0)]
    impl M__DojoStoredModelImpl =
        dojo::model::component::IStoredModelImpl<ContractState, M>;

    #[abi(embed_v0)]
    impl M__DojoModelImpl = dojo::model::component::IModelImpl<ContractState, M>;

    #[abi(per_item)]
    #[generate_trait]
    impl MImpl of IM {
        // Ensures the ABI contains the Model struct, even if never used
        // into as a system input.
        #[external(v0)]
        fn ensure_abi(self: @ContractState, model: M) {
            let _model = model;
        }

        // Outputs ModelValue to allow a simple diff from the ABI compared to the
        // model to retrieved the keys of a model.
        #[external(v0)]
        fn ensure_values(self: @ContractState, value: MValue) {
            let _value = value;
        }

        // Ensures the generated contract has a unique classhash, using
        // a hardcoded hash computed on model and member names.
        #[external(v0)]
        fn ensure_unique(self: @ContractState) {
            let _hash =
                2849041847227450344427958839906774949501046181878702978795441262043345740368;
        }
    }
}

#[derive(Serde, Drop)]
pub struct E<> {
    #[key]
    pub k: felt252,
    pub v: u32,
}


impl EIntrospect of dojo::meta::introspect::Introspect<E> {
    #[inline(always)]
    fn size() -> Option<usize> {
        dojo::meta::introspect::Introspect::<u32>::size()
    }
    #[inline(always)]
    fn layout() -> dojo::meta::Layout {
        dojo::meta::Layout::Struct(
            array![
                dojo::meta::FieldLayout {
                    selector: 578691550836206188651404750433984985630363913126316857592149308417275000080,
                    layout: dojo::meta::introspect::Introspect::<u32>::layout(),
                },
            ]
                .span(),
        )
    }
    #[inline(always)]
    fn ty() -> dojo::meta::introspect::Ty {
        dojo::meta::introspect::Ty::Struct(
            dojo::meta::introspect::Struct {
                name: 'E',
                attrs: array![].span(),
                children: array![
                    dojo::meta::introspect::Member {
                        name: 'k',
                        attrs: array!['key'].span(),
                        ty: dojo::meta::introspect::Introspect::<felt252>::ty(),
                    },
                    dojo::meta::introspect::Member {
                        name: 'v',
                        attrs: array![].span(),
                        ty: dojo::meta::introspect::Introspect::<u32>::ty(),
                    },
                ]
                    .span(),
            },
        )
    }
}


// EventValue on it's own does nothing since events are always emitted and
// never read from the storage. However, it's required by the ABI to
// ensure that the event definition contains both keys and values easily distinguishable.
// Only derives strictly required traits.
#[derive(Serde, Drop)]
pub struct EValue {
    pub v: u32,
}


impl EValueIntrospect of dojo::meta::introspect::Introspect<EValue> {
    #[inline(always)]
    fn size() -> Option<usize> {
        dojo::meta::introspect::Introspect::<u32>::size()
    }
    #[inline(always)]
    fn layout() -> dojo::meta::Layout {
        dojo::meta::Layout::Struct(
            array![
                dojo::meta::FieldLayout {
                    selector: 578691550836206188651404750433984985630363913126316857592149308417275000080,
                    layout: dojo::meta::introspect::Introspect::<u32>::layout(),
                },
            ]
                .span(),
        )
    }
    #[inline(always)]
    fn ty() -> dojo::meta::introspect::Ty {
        dojo::meta::introspect::Ty::Struct(
            dojo::meta::introspect::Struct {
                name: 'EValue',
                attrs: array![].span(),
                children: array![
                    dojo::meta::introspect::Member {
                        name: 'v',
                        attrs: array![].span(),
                        ty: dojo::meta::introspect::Introspect::<u32>::ty(),
                    },
                ]
                    .span(),
            },
        )
    }
}


pub impl EDefinition of dojo::event::EventDefinition<E> {
    #[inline(always)]
    fn name() -> ByteArray {
        "E"
    }
}

pub impl EModelParser of dojo::model::model::ModelParser<E> {
    fn deserialize(ref keys: Span<felt252>, ref values: Span<felt252>) -> Option<E> {
        let mut serialized: Array<felt252> = keys.into();
        serialized.append_span(values);
        let mut data = serialized.span();

        // always use Serde as event data are never stored in the world storage.
        core::serde::Serde::<E>::deserialize(ref data)
    }
    fn serialize_keys(self: @E) -> Span<felt252> {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(self.k, ref serialized);

        core::array::ArrayTrait::span(@serialized)
    }
    fn serialize_values(self: @E) -> Span<felt252> {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(self.v, ref serialized);

        core::array::ArrayTrait::span(@serialized)
    }
}

pub impl EEventImpl = dojo::event::event::EventImpl<E>;

#[starknet::contract]
pub mod e_E {
    use super::{E, EValue};

    #[storage]
    struct Storage {}

    #[abi(embed_v0)]
    impl E__DeployedEventImpl =
        dojo::event::component::IDeployedEventImpl<ContractState, E>;

    #[abi(embed_v0)]
    impl E__StoredEventImpl =
        dojo::event::component::IStoredEventImpl<ContractState, E>;

    #[abi(embed_v0)]
    impl E__EventImpl = dojo::event::component::IEventImpl<ContractState, E>;

    #[abi(per_item)]
    #[generate_trait]
    impl EImpl of IE {
        // Ensures the ABI contains the Event struct, since it's never used
        // by systems directly.
        #[external(v0)]
        fn ensure_abi(self: @ContractState, event: E) {
            let _event = event;
        }

        // Outputs EventValue to allow a simple diff from the ABI compared to the
        // event to retrieved the keys of an event.
        #[external(v0)]
        fn ensure_values(self: @ContractState, value: EValue) {
            let _value = value;
        }

        // Ensures the generated contract has a unique classhash, using
        // a hardcoded hash computed on event and member names.
        #[external(v0)]
        fn ensure_unique(self: @ContractState) {
            let _hash =
                1954984139733333964498936181682115663372935529816993893359036110076230488447;
        }
    }
}

#[derive(Serde, Drop)]
pub struct EH<> {
    #[key]
    pub k: felt252,
    pub v: u32,
}


impl EHIntrospect of dojo::meta::introspect::Introspect<EH> {
    #[inline(always)]
    fn size() -> Option<usize> {
        dojo::meta::introspect::Introspect::<u32>::size()
    }
    #[inline(always)]
    fn layout() -> dojo::meta::Layout {
        dojo::meta::Layout::Struct(
            array![
                dojo::meta::FieldLayout {
                    selector: 578691550836206188651404750433984985630363913126316857592149308417275000080,
                    layout: dojo::meta::introspect::Introspect::<u32>::layout(),
                },
            ]
                .span(),
        )
    }
    #[inline(always)]
    fn ty() -> dojo::meta::introspect::Ty {
        dojo::meta::introspect::Ty::Struct(
            dojo::meta::introspect::Struct {
                name: 'EH',
                attrs: array![].span(),
                children: array![
                    dojo::meta::introspect::Member {
                        name: 'k',
                        attrs: array!['key'].span(),
                        ty: dojo::meta::introspect::Introspect::<felt252>::ty(),
                    },
                    dojo::meta::introspect::Member {
                        name: 'v',
                        attrs: array![].span(),
                        ty: dojo::meta::introspect::Introspect::<u32>::ty(),
                    },
                ]
                    .span(),
            },
        )
    }
}


// EventValue on it's own does nothing since events are always emitted and
// never read from the storage. However, it's required by the ABI to
// ensure that the event definition contains both keys and values easily distinguishable.
// Only derives strictly required traits.
#[derive(Serde, Drop)]
pub struct EHValue {
    pub v: u32,
}

impl EHValueIntrospect of dojo::meta::introspect::Introspect<EHValue> {
    #[inline(always)]
    fn size() -> Option<usize> {
        dojo::meta::introspect::Introspect::<u32>::size()
    }
    #[inline(always)]
    fn layout() -> dojo::meta::Layout {
        dojo::meta::Layout::Struct(
            array![
                dojo::meta::FieldLayout {
                    selector: 578691550836206188651404750433984985630363913126316857592149308417275000080,
                    layout: dojo::meta::introspect::Introspect::<u32>::layout(),
                },
            ]
                .span(),
        )
    }
    #[inline(always)]
    fn ty() -> dojo::meta::introspect::Ty {
        dojo::meta::introspect::Ty::Struct(
            dojo::meta::introspect::Struct {
                name: 'EHValue',
                attrs: array![].span(),
                children: array![
                    dojo::meta::introspect::Member {
                        name: 'v',
                        attrs: array![].span(),
                        ty: dojo::meta::introspect::Introspect::<u32>::ty(),
                    },
                ]
                    .span(),
            },
        )
    }
}


pub impl EHDefinition of dojo::event::EventDefinition<EH> {
    #[inline(always)]
    fn name() -> ByteArray {
        "EH"
    }
}

pub impl EHModelParser of dojo::model::model::ModelParser<EH> {
    fn deserialize(ref keys: Span<felt252>, ref values: Span<felt252>) -> Option<EH> {
        let mut serialized: Array<felt252> = keys.into();
        serialized.append_span(values);
        let mut data = serialized.span();

        // always use Serde as event data are never stored in the world storage.
        core::serde::Serde::<EH>::deserialize(ref data)
    }
    fn serialize_keys(self: @EH) -> Span<felt252> {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(self.k, ref serialized);

        core::array::ArrayTrait::span(@serialized)
    }
    fn serialize_values(self: @EH) -> Span<felt252> {
        let mut serialized = core::array::ArrayTrait::new();
        core::serde::Serde::serialize(self.v, ref serialized);

        core::array::ArrayTrait::span(@serialized)
    }
}

pub impl EHEventImpl = dojo::event::event::EventImpl<EH>;

#[starknet::contract]
pub mod e_EH {
    use super::{EH, EHValue};

    #[storage]
    struct Storage {}

    #[abi(embed_v0)]
    impl EH__DeployedEventImpl =
        dojo::event::component::IDeployedEventImpl<ContractState, EH>;

    #[abi(embed_v0)]
    impl EH__StoredEventImpl =
        dojo::event::component::IStoredEventImpl<ContractState, EH>;

    #[abi(embed_v0)]
    impl EH__EventImpl = dojo::event::component::IEventImpl<ContractState, EH>;

    #[abi(per_item)]
    #[generate_trait]
    impl EHImpl of IEH {
        // Ensures the ABI contains the Event struct, since it's never used
        // by systems directly.
        #[external(v0)]
        fn ensure_abi(self: @ContractState, event: EH) {
            let _event = event;
        }

        // Outputs EventValue to allow a simple diff from the ABI compared to the
        // event to retrieved the keys of an event.
        #[external(v0)]
        fn ensure_values(self: @ContractState, value: EHValue) {
            let _value = value;
        }

        // Ensures the generated contract has a unique classhash, using
        // a hardcoded hash computed on event and member names.
        #[external(v0)]
        fn ensure_unique(self: @ContractState) {
            let _hash = 535079072247699314064384426321757771782747026384720315941531670532077955480;
        }
    }
}

#[starknet::interface]
pub trait MyInterface<T> {
    fn system_1(ref self: T, k: felt252, v: felt252);
    fn system_2(ref self: T, k: felt252) -> felt252;
    fn system_3(ref self: T, k: felt252, v: u32);
    fn system_4(ref self: T, k: felt252);
    fn system_dbg(
        ref self: T, objective_ids: Option<Span<u32>>, game_context: Option<GameContextDetails>,
    );
}

#[starknet::contract]
pub mod c1 {
    use dojo::contract::IContract;
    use dojo::contract::components::upgradeable::upgradeable_cpt;
    use dojo::contract::components::world_provider::world_provider_cpt::InternalTrait as WorldProviderInternal;
    use dojo::contract::components::world_provider::{IWorldProvider, world_provider_cpt};
    use dojo::meta::IDeployedResource;
    component!(path: world_provider_cpt, storage: world_provider, event: WorldProviderEvent);
    component!(path: upgradeable_cpt, storage: upgradeable, event: UpgradeableEvent);
    #[abi(embed_v0)]
    impl WorldProviderImpl = world_provider_cpt::WorldProviderImpl<ContractState>;
    #[abi(embed_v0)]
    impl UpgradeableImpl = upgradeable_cpt::UpgradeableImpl<ContractState>;
    #[abi(embed_v0)]
    pub impl c1__ContractImpl of IContract<ContractState> {}
    #[abi(embed_v0)]
    pub impl DojoDeployedContractImpl of IDeployedResource<ContractState> {
        fn dojo_name(self: @ContractState) -> ByteArray {
            "c1"
        }
    }
    #[generate_trait]
    impl DojoContractInternalImpl of DojoContractInternalTrait {
        fn world(
            self: @ContractState, namespace: @ByteArray,
        ) -> dojo::world::storage::WorldStorage {
            dojo::world::WorldStorageTrait::new(self.world_provider.world_dispatcher(), namespace)
        }
        fn world_ns_hash(
            self: @ContractState, namespace_hash: felt252,
        ) -> dojo::world::storage::WorldStorage {
            dojo::world::WorldStorageTrait::new_from_hash(
                self.world_provider.world_dispatcher(), namespace_hash,
            )
        }
    }
    use dojo::event::EventStorage;
    use dojo::model::{Model, ModelStorage, ModelValueStorage};
    use super::{E, EH, GameContextDetails, M, MValue, MyInterface, MyInterfaceDispatcherTrait};
    #[abi(per_item)]
    #[generate_trait]
    pub impl IDojoInitImpl of IDojoInit {
        #[external(v0)]
        fn dojo_init(self: @ContractState, v: felt252) {
            if starknet::get_caller_address() != self
                .world_provider
                .world_dispatcher()
                .contract_address {
                core::panics::panic_with_byte_array(
                    @format!(
                        "Only the world can init contract `{}`, but caller is `{:?}`",
                        self.dojo_name(),
                        starknet::get_caller_address(),
                    ),
                );
            }
            {
                let m = M { k: 0, v };

                let mut world = self.world_default();
                world.write_model(@m);
            }
        }
    }
    #[abi(embed_v0)]
    impl MyInterfaceImpl of MyInterface<ContractState> {
        fn system_1(ref self: ContractState, k: felt252, v: felt252) {
            let mut world = self.world_default();

            let m = M { k, v };

            world.write_model(@m)
        }

        fn system_2(ref self: ContractState, k: felt252) -> felt252 {
            let mut world = self.world_default();

            let m: M = world.read_model(k);

            m.v
        }

        fn system_3(ref self: ContractState, k: felt252, v: u32) {
            let mut world = self.world_default();

            let e = E { k, v };
            world.emit_event(@e);

            let eh = EH { k, v };
            world.emit_event(@eh);
        }

        fn system_4(ref self: ContractState, k: felt252) {
            let mut world = self.world_default();

            let m = M { k, v: 288 };

            let entity_id = Model::<M>::entity_id(@m);

            world.write_model(@m);
            world.erase_model(@m);

            let mut mv: MValue = world.read_value_from_id(entity_id);
            mv.v = 12;
            world.write_value_from_id(entity_id, @mv);

            world.erase_model_ptr(Model::<M>::ptr_from_id(entity_id));
        }

        fn system_dbg(
            ref self: ContractState,
            objective_ids: Option<Span<u32>>,
            game_context: Option<GameContextDetails>,
        ) {
            let d = super::MyInterfaceDispatcher {
                contract_address: starknet::get_contract_address(),
            };

            let empty_objective_ids: Span<u32> = array![].span();

            d.system_dbg(Option::Some(empty_objective_ids), None);
        }
    }

    #[generate_trait]
    impl InternalImpl of InternalTrait {
        // Need a function since byte array can't be const.
        // We could have a self.world with an other function to init from hash, that can be
        // constant.
        fn world_default(self: @ContractState) -> dojo::world::WorldStorage {
            self.world(@"ns")
        }
    }
    #[constructor]
    fn constructor(ref self: ContractState) {
        self.world_provider.initializer();
    }
    #[event]
    #[derive(Drop, starknet::Event)]
    enum Event {
        UpgradeableEvent: upgradeable_cpt::Event,
        WorldProviderEvent: world_provider_cpt::Event,
    }
    #[storage]
    struct Storage {
        #[substorage(v0)]
        upgradeable: upgradeable_cpt::Storage,
        #[substorage(v0)]
        world_provider: world_provider_cpt::Storage,
    }
}

#[starknet::contract]
pub mod c2 {
    use dojo::contract::IContract;
    use dojo::contract::components::upgradeable::upgradeable_cpt;
    use dojo::contract::components::world_provider::world_provider_cpt::InternalTrait as WorldProviderInternal;
    use dojo::contract::components::world_provider::{IWorldProvider, world_provider_cpt};
    use dojo::meta::IDeployedResource;
    component!(path: world_provider_cpt, storage: world_provider, event: WorldProviderEvent);
    component!(path: upgradeable_cpt, storage: upgradeable, event: UpgradeableEvent);
    #[abi(embed_v0)]
    impl WorldProviderImpl = world_provider_cpt::WorldProviderImpl<ContractState>;
    #[abi(embed_v0)]
    impl UpgradeableImpl = upgradeable_cpt::UpgradeableImpl<ContractState>;
    #[abi(embed_v0)]
    pub impl c2__ContractImpl of IContract<ContractState> {}
    #[abi(embed_v0)]
    pub impl DojoDeployedContractImpl of IDeployedResource<ContractState> {
        fn dojo_name(self: @ContractState) -> ByteArray {
            "c2"
        }
    }
    #[generate_trait]
    impl DojoContractInternalImpl of DojoContractInternalTrait {
        fn world(
            self: @ContractState, namespace: @ByteArray,
        ) -> dojo::world::storage::WorldStorage {
            dojo::world::WorldStorageTrait::new(self.world_provider.world_dispatcher(), namespace)
        }
        fn world_ns_hash(
            self: @ContractState, namespace_hash: felt252,
        ) -> dojo::world::storage::WorldStorage {
            dojo::world::WorldStorageTrait::new_from_hash(
                self.world_provider.world_dispatcher(), namespace_hash,
            )
        }
    }
    #[constructor]
    fn constructor(ref self: ContractState) {
        self.world_provider.initializer();
    }
    #[abi(per_item)]
    #[generate_trait]
    pub impl IDojoInitImpl of IDojoInit {
        #[external(v0)]
        fn dojo_init(self: @ContractState) {
            if starknet::get_caller_address() != self
                .world_provider
                .world_dispatcher()
                .contract_address {
                core::panics::panic_with_byte_array(
                    @format!(
                        "Only the world can init contract `{}`, but caller is `{:?}`",
                        self.dojo_name(),
                        starknet::get_caller_address(),
                    ),
                );
            }
        }
    }
    #[event]
    #[derive(Drop, starknet::Event)]
    enum Event {
        UpgradeableEvent: upgradeable_cpt::Event,
        WorldProviderEvent: world_provider_cpt::Event,
    }
    #[storage]
    struct Storage {
        #[substorage(v0)]
        upgradeable: upgradeable_cpt::Storage,
        #[substorage(v0)]
        world_provider: world_provider_cpt::Storage,
    }
}

#[starknet::contract]
pub mod c3 {
    use dojo::contract::IContract;
    use dojo::contract::components::upgradeable::upgradeable_cpt;
    use dojo::contract::components::world_provider::world_provider_cpt::InternalTrait as WorldProviderInternal;
    use dojo::contract::components::world_provider::{IWorldProvider, world_provider_cpt};
    use dojo::meta::IDeployedResource;
    component!(path: world_provider_cpt, storage: world_provider, event: WorldProviderEvent);
    component!(path: upgradeable_cpt, storage: upgradeable, event: UpgradeableEvent);
    #[abi(embed_v0)]
    impl WorldProviderImpl = world_provider_cpt::WorldProviderImpl<ContractState>;
    #[abi(embed_v0)]
    impl UpgradeableImpl = upgradeable_cpt::UpgradeableImpl<ContractState>;
    #[abi(embed_v0)]
    pub impl c3__ContractImpl of IContract<ContractState> {}
    #[abi(embed_v0)]
    pub impl DojoDeployedContractImpl of IDeployedResource<ContractState> {
        fn dojo_name(self: @ContractState) -> ByteArray {
            "c3"
        }
    }
    #[generate_trait]
    impl DojoContractInternalImpl of DojoContractInternalTrait {
        fn world(
            self: @ContractState, namespace: @ByteArray,
        ) -> dojo::world::storage::WorldStorage {
            dojo::world::WorldStorageTrait::new(self.world_provider.world_dispatcher(), namespace)
        }
        fn world_ns_hash(
            self: @ContractState, namespace_hash: felt252,
        ) -> dojo::world::storage::WorldStorage {
            dojo::world::WorldStorageTrait::new_from_hash(
                self.world_provider.world_dispatcher(), namespace_hash,
            )
        }
    }
    #[constructor]
    fn constructor(ref self: ContractState) {
        self.world_provider.initializer();
    }
    #[abi(per_item)]
    #[generate_trait]
    pub impl IDojoInitImpl of IDojoInit {
        #[external(v0)]
        fn dojo_init(self: @ContractState) {
            if starknet::get_caller_address() != self
                .world_provider
                .world_dispatcher()
                .contract_address {
                core::panics::panic_with_byte_array(
                    @format!(
                        "Only the world can init contract `{}`, but caller is `{:?}`",
                        self.dojo_name(),
                        starknet::get_caller_address(),
                    ),
                );
            }
        }
    }
    #[event]
    #[derive(Drop, starknet::Event)]
    enum Event {
        UpgradeableEvent: upgradeable_cpt::Event,
        WorldProviderEvent: world_provider_cpt::Event,
    }
    #[storage]
    struct Storage {
        #[substorage(v0)]
        upgradeable: upgradeable_cpt::Storage,
        #[substorage(v0)]
        world_provider: world_provider_cpt::Storage,
    }
}

#[cfg(test)]
mod tests {
    use dojo::model::ModelStorage;
    use dojo_cairo_test::{
        ContractDefTrait, NamespaceDef, TestResource, WorldStorageTestTrait, spawn_test_world,
    };
    use super::{M, c1, m_M};

    #[test]
    fn test_1() {
        let ndef = NamespaceDef {
            namespace: "ns",
            resources: [
                TestResource::Model(m_M::TEST_CLASS_HASH.try_into().unwrap()),
                TestResource::Contract(c1::TEST_CLASS_HASH.try_into().unwrap()),
            ]
                .span(),
        };

        let world = spawn_test_world([ndef].span());

        let c1_def = ContractDefTrait::new(@"ns", @"c1")
            .with_writer_of([dojo::utils::bytearray_hash(@"ns")].span())
            .with_init_calldata([0xff].span());

        world.sync_perms_and_inits([c1_def].span());

        let m: M = world.read_model(0);
        assert!(m.v == 0xff, "invalid b");
    }
}
