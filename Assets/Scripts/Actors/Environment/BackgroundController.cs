using UnityEngine;
using static Managers.TagsAsStrings;

namespace Actors.Environment {
    public class BackgroundController : MonoBehaviour {
        private ParticleSystem[] _backgroundStarSystems;
        private GameObject _nebulaSprite;
        private Vector3 _playerPosition;
        private Transform _playerTransform;


        private void Awake(){
            _nebulaSprite = GameObject.FindWithTag(nebulaTag);

            _playerTransform = GameObject.FindWithTag(playerTag).GetComponent<Transform>();
            _backgroundStarSystems = GetComponentsInChildren<ParticleSystem>();
        }

        public void BatchUpdate(){
            _playerPosition = _playerTransform.position;
            _backgroundStarSystems[0].transform.position = -_playerPosition * 0.09f;

            ParticleSystem.ShapeModule shapeModule = _backgroundStarSystems[1].shape;
            Vector3 shapeModuleRotation = shapeModule.rotation;
            shapeModuleRotation.x = -_playerPosition.x * 0.05f;
            shapeModuleRotation.y = -90 + -_playerPosition.x * 0.05f;
            shapeModule.rotation = shapeModuleRotation;
            _nebulaSprite.transform.localPosition = -_playerPosition * 0.05f;
        }
    }
}