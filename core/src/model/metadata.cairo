//! ResourceMetadata model.
//!
use dojo::model::model::Model;
use dojo::utils;

// #[derive(PartialEq, Clone, Debug)]
// #[dojo::model]
// pub struct ResourceMetadata {
//     #[key]
//     pub resource_id: felt252,
//     pub metadata_uri: ByteArray,
//     pub metadata_hash: felt252,
// }

#[derive(PartialEq, Clone, Debug,   Serde, Drop)] pub  struct ResourceMetadata <>{    #[key]
    pub resource_id: felt252,
    pub metadata_uri: ByteArray,
    pub metadata_hash: felt252,
} 

impl ResourceMetadataIntrospect of dojo::meta::introspect::Introspect<ResourceMetadata>{#[inline(always)]fn size()->Option<usize>{dojo::utils::sum_sizes(array![Option::None,
dojo::meta::introspect::Introspect::<felt252>::size()])}#[inline(always)]fn layout()->dojo::meta::Layout{dojo::meta::Layout::Struct(
                array![
                dojo::meta::FieldLayout {
                    selector: 815903823124453119243971298555977249487241195972064209763947138938752137060,
                    layout: dojo::meta::introspect::Introspect::<ByteArray>::layout()
                },
dojo::meta::FieldLayout {
                    selector: 402691337825421667503868820051170339614598047369162010078678677170542176093,
                    layout: dojo::meta::introspect::Introspect::<felt252>::layout()
                }
                ].span()
            )}#[inline(always)]fn ty()->dojo::meta::introspect::Ty{dojo::meta::introspect::Ty::Struct(
            dojo::meta::introspect::Struct {
                name: 'ResourceMetadata',
                attrs: array![].span(),
                children: array![
                dojo::meta::introspect::Member {
            name: 'resource_id',
            attrs: array!['key'].span(),
            ty: dojo::meta::introspect::Introspect::<felt252>::ty()
        },
dojo::meta::introspect::Member {
            name: 'metadata_uri',
            attrs: array![].span(),
            ty: dojo::meta::introspect::Ty::ByteArray
        },
dojo::meta::introspect::Member {
            name: 'metadata_hash',
            attrs: array![].span(),
            ty: dojo::meta::introspect::Introspect::<felt252>::ty()
        }

                ].span()
            }
        )}}


impl ResourceMetadataDojoStore of dojo::storage::DojoStore<ResourceMetadata> {
        fn dojo_serialize(self: @ResourceMetadata, ref serialized: Array<felt252>) {
            dojo::storage::DojoStore::dojo_serialize(self.resource_id, ref serialized);
dojo::storage::DojoStore::dojo_serialize(self.metadata_uri, ref serialized);
dojo::storage::DojoStore::dojo_serialize(self.metadata_hash, ref serialized);

        }
        fn dojo_deserialize(ref values: Span<felt252>) -> Option<ResourceMetadata> {
            let resource_id = dojo::storage::DojoStore::<felt252>::dojo_deserialize(ref values)?;
let metadata_uri = dojo::storage::DojoStore::<ByteArray>::dojo_deserialize(ref values)?;
let metadata_hash = dojo::storage::DojoStore::<felt252>::dojo_deserialize(ref values)?;

            Option::Some(ResourceMetadata {
                resource_id,
metadata_uri,
metadata_hash
            })
        }
    }



#[derive(PartialEq, Clone, Debug, Serde, Drop)]
pub struct ResourceMetadataValue {
    pub metadata_uri: ByteArray,
pub metadata_hash: felt252,

}


impl ResourceMetadataValueIntrospect of dojo::meta::introspect::Introspect<ResourceMetadataValue>{#[inline(always)]fn size()->Option<usize>{dojo::utils::sum_sizes(array![Option::None,
dojo::meta::introspect::Introspect::<felt252>::size()])}#[inline(always)]fn layout()->dojo::meta::Layout{dojo::meta::Layout::Struct(
                array![
                dojo::meta::FieldLayout {
                    selector: 815903823124453119243971298555977249487241195972064209763947138938752137060,
                    layout: dojo::meta::introspect::Introspect::<ByteArray>::layout()
                },
dojo::meta::FieldLayout {
                    selector: 402691337825421667503868820051170339614598047369162010078678677170542176093,
                    layout: dojo::meta::introspect::Introspect::<felt252>::layout()
                }
                ].span()
            )}#[inline(always)]fn ty()->dojo::meta::introspect::Ty{dojo::meta::introspect::Ty::Struct(
            dojo::meta::introspect::Struct {
                name: 'ResourceMetadataValue',
                attrs: array![].span(),
                children: array![
                dojo::meta::introspect::Member {
            name: 'metadata_uri',
            attrs: array![].span(),
            ty: dojo::meta::introspect::Ty::ByteArray
        },
dojo::meta::introspect::Member {
            name: 'metadata_hash',
            attrs: array![].span(),
            ty: dojo::meta::introspect::Introspect::<felt252>::ty()
        }

                ].span()
            }
        )}}


impl ResourceMetadataValueDojoStore of dojo::storage::DojoStore<ResourceMetadataValue> {
        fn dojo_serialize(self: @ResourceMetadataValue, ref serialized: Array<felt252>) {
            dojo::storage::DojoStore::dojo_serialize(self.metadata_uri, ref serialized);
dojo::storage::DojoStore::dojo_serialize(self.metadata_hash, ref serialized);

        }
        fn dojo_deserialize(ref values: Span<felt252>) -> Option<ResourceMetadataValue> {
            let metadata_uri = dojo::storage::DojoStore::<ByteArray>::dojo_deserialize(ref values)?;
let metadata_hash = dojo::storage::DojoStore::<felt252>::dojo_deserialize(ref values)?;

            Option::Some(ResourceMetadataValue {
                metadata_uri,
metadata_hash
            })
        }
    }


type ResourceMetadataKeyType = felt252;

pub impl ResourceMetadataKeyParser of dojo::model::model::KeyParser<ResourceMetadata, ResourceMetadataKeyType> {
    #[inline(always)]
    fn parse_key(self: @ResourceMetadata) -> ResourceMetadataKeyType {
        *self.resource_id
    }
}

impl ResourceMetadataModelValueKey of dojo::model::model_value::ModelValueKey<ResourceMetadataValue, ResourceMetadataKeyType> {
}

// Impl to get the static definition of a model
pub mod m_ResourceMetadata_definition {
    use super::ResourceMetadata;
    pub impl ResourceMetadataDefinitionImpl<T> of dojo::model::ModelDefinition<T>{
        #[inline(always)]
        fn name() -> ByteArray {
            "ResourceMetadata"
        }

        #[inline(always)]
        fn layout() -> dojo::meta::Layout {
            dojo::meta::Introspect::<ResourceMetadata>::layout()
        }

        #[inline(always)]
        fn use_legacy_storage() -> bool {
            false
        }

        #[inline(always)]
        fn schema() -> dojo::meta::introspect::Struct {
            if let dojo::meta::introspect::Ty::Struct(s) = dojo::meta::Introspect::<ResourceMetadata>::ty() {
                s
            }
            else {
                panic!("Model ResourceMetadata: invalid schema.")
            }
        }

        #[inline(always)]
        fn size() -> Option<usize> {
            dojo::meta::Introspect::<ResourceMetadata>::size()
        }
    }
}

pub impl ResourceMetadataDefinition = m_ResourceMetadata_definition::ResourceMetadataDefinitionImpl<ResourceMetadata>;
pub impl ResourceMetadataModelValueDefinition = m_ResourceMetadata_definition::ResourceMetadataDefinitionImpl<ResourceMetadataValue>;

pub impl ResourceMetadataModelParser of dojo::model::model::ModelParser<ResourceMetadata> {
    fn deserialize(ref keys: Span<felt252>, ref values: Span<felt252>) -> Option<ResourceMetadata> {
        
            let resource_id = core::serde::Serde::<felt252>::deserialize(ref keys)?;

            let metadata_uri = dojo::storage::DojoStore::<ByteArray>::dojo_deserialize(ref values)?;

let metadata_hash = dojo::storage::DojoStore::<felt252>::dojo_deserialize(ref values)?;


            Some(ResourceMetadata {
                resource_id,
                metadata_uri,
metadata_hash,
            })
            
    }
    fn serialize_keys(self: @ResourceMetadata) -> Span<felt252> {
        let mut serialized = core::array::ArrayTrait::new();
        dojo::storage::DojoStore::dojo_serialize(self.resource_id, ref serialized);

        core::array::ArrayTrait::span(@serialized)
    }
    fn serialize_values(self: @ResourceMetadata) -> Span<felt252> {
        let mut serialized = core::array::ArrayTrait::new();
        dojo::storage::DojoStore::dojo_serialize(self.metadata_uri, ref serialized);
dojo::storage::DojoStore::dojo_serialize(self.metadata_hash, ref serialized);

        core::array::ArrayTrait::span(@serialized)
    }
}

pub impl ResourceMetadataModelValueParser of dojo::model::model_value::ModelValueParser<ResourceMetadataValue> {
    fn deserialize(ref values: Span<felt252>) -> Option<ResourceMetadataValue> {
    dojo::storage::DojoStore::<ResourceMetadataValue>::dojo_deserialize(ref values)
    }
    fn serialize_values(self: @ResourceMetadataValue) -> Span<felt252> {
        let mut serialized = core::array::ArrayTrait::new();
        dojo::storage::DojoStore::dojo_serialize(self.metadata_uri, ref serialized);
dojo::storage::DojoStore::dojo_serialize(self.metadata_hash, ref serialized);

        core::array::ArrayTrait::span(@serialized)
    }
}

// Note that ResourceMetadataDojoStore is implemented through the DojoStore derive attribute
// as any structs.

pub impl ResourceMetadataModelImpl = dojo::model::model::ModelImpl<ResourceMetadata>;
pub impl ResourceMetadataModelValueImpl = dojo::model::model_value::ModelValueImpl<ResourceMetadataValue>;


#[starknet::contract]
pub mod m_ResourceMetadata {
    use super::ResourceMetadata;
    use super::ResourceMetadataValue;

    #[storage]
    struct Storage {}

    #[abi(embed_v0)]
    impl ResourceMetadata__DojoDeployedModelImpl = dojo::model::component::IDeployedModelImpl<ContractState, ResourceMetadata>;

    #[abi(embed_v0)]
    impl ResourceMetadata__DojoStoredModelImpl = dojo::model::component::IStoredModelImpl<ContractState, ResourceMetadata>;

    #[abi(embed_v0)]
    impl ResourceMetadata__DojoModelImpl = dojo::model::component::IModelImpl<ContractState, ResourceMetadata>;

    #[abi(per_item)]
    #[generate_trait]
    impl ResourceMetadataImpl of IResourceMetadata {
        // Ensures the ABI contains the Model struct, even if never used
        // into as a system input.
        #[external(v0)]
        fn ensure_abi(self: @ContractState, model: ResourceMetadata) {
            let _model = model;
        }

        // Outputs ModelValue to allow a simple diff from the ABI compared to the
        // model to retrieved the keys of a model.
        #[external(v0)]
        fn ensure_values(self: @ContractState, value: ResourceMetadataValue) {
            let _value = value;
        }

        // Ensures the generated contract has a unique classhash, using
        // a hardcoded hash computed on model and member names.
        #[external(v0)]
        fn ensure_unique(self: @ContractState) {
            let _hash = 2963832507061196967919282170979195677022405859521625430557943352237935787452;
        }
    }
}

pub fn resource_metadata_selector(default_namespace_hash: felt252) -> felt252 {
    utils::selector_from_namespace_and_name(
        default_namespace_hash, @Model::<ResourceMetadata>::name(),
    )
}
